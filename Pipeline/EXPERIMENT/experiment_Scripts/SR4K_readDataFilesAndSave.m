clear
clc

%% TEST TYPE (modify here)
CameraType = 'SR4K';	%		'SR4K' | 'SENZ3D'
WithMovement = 'N';		%		'Y' | 'N'
ChangeType = '0NoChange10';	%	['0NoChange1' to '0NoChange10']
										% 'S' | 'D' | '1' | '2' | '3' | '4' | '5' 
										% 'SH' | 'SV' | 'Fist'
positionScaling = 10;

%% GLOBALS (DO NOT MODIFY FROM HERE DOWN)
rawPath = strcat('C:\Users\XJLM\Documents\MATLAB\3DSCD\raw_sr4kScans\',CameraType,'_',WithMovement,'_',ChangeType,'\');
downsampleRatio = 1;
crop_ratio = 0.5;
cropWidth = round(176 * crop_ratio);
cropHeight = round(144 * crop_ratio);

%% READ IN ALL SCANS
scanFilesPrefixes = {	strcat(rawPath, WithMovement, '_', ChangeType, '_v0'),	...
											strcat(rawPath, WithMovement, '_', ChangeType, '_v1'),	...
											strcat(rawPath, WithMovement, '_', ChangeType, '_v2'),	...
                     };
names = {	'v0',	...
					'v1',	...
					'v2',	...
				};
fn = size(scanFilesPrefixes,2);

%preallocate storage
REFs{fn} = [];
IMGs{fn} = [];
DD{fn} = [];
XX{fn} = [];
YY{fn} = [];
AA{fn} = [];
CC{fn} = [];
ROMIref{fn} = [];
ROMIthis{fn} = [];
SURF{fn} = [];

for i=1:fn
	[D, X, Y, A, C] = SR4K_readScan( scanFilesPrefixes{i}, cropWidth, cropHeight, 'avg' );
	  
  DD{i} = D;
  XX{i} = X;
  YY{i} = Y;  
	AA{i} = A;
  CC{i} = C;
	
	REFs{i} = imresize( positionScaling.*D.*C, downsampleRatio );
	IMGs{i} = A;
  	
	if (i==1)
		SURF{1} = REFs{1};
	end
end

clear CD D X Y A C cropHeight crop_ratio cropWidth downsampleRatio i fn;

%% SAVE FILENAME
resourceFolderPath = mfilename('fullpath');
resourceFolderPath = strcat(resourceFolderPath(1:end-25), '..\resource\');
var_filepath = experiment_generateExpSetFilepath( CameraType, WithMovement, ChangeType, resourceFolderPath );
save(var_filepath,	'REFs', ...
										'IMGs',	...
										'DD',		...
										'XX',		...
										'YY',		...
										'AA',		...
										'CC',		...
										'ROMIref',	...
										'ROMIthis',	...
										'SURF',	...
										'names'	...
									);
%% finish
fprintf('Experiment Resource stored at:\n\t%s\n', var_filepath);
clear