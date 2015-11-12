clear
clc

%% TEST TYPE (modify here)
% rawPath = 'C:\Users\XJLM\Documents\MATLAB\3DSCD\resource\TestSet\';
CameraType = 'SENZ3D';	%		'SR4K' | 'SENZ3D'
WithMovement = 'Y';		%		'Y' | 'N'
ChangeType = 'S';	%	['0NoChange1' to '0NoChange10']
										% 'S' | 'D' | '1' | '2' | '3' | '4' | '5' 
										% 'SH' | 'SV' | 'Fist'

%% GLOBALS (DO NOT MODIFY FROM HERE DOWN)
downsampleRatio = 1;
crop_ratio = 0.5;
cropWidth = round(176 * crop_ratio);		% use the SR4K's viewcrop instead
cropHeight = round(144 * crop_ratio);
fn = 3;
frames = 20;

%% PREALLOCATE STORAGE
REFs{fn} = [];
IMGs{fn} = [];
ROMIref{fn} = [];
ROMIthis{fn} = [];
SURF{fn} = [];
names = {	'v0',	...
					'v1',	...
					'v2',	...
				};

%% BEGIN 3-SCAN PROCESS
input('Press Enter to Capture v0: \n');
[D, I] = SENZ3D_takeScan(frames, crop_ratio, downsampleRatio);
REFs{1} = D;
IMGs{1} = I;
SURF{1} = D;

input('Press Enter to Capture v1: \n');
[D, I] = SENZ3D_takeScan(frames, crop_ratio, downsampleRatio);
REFs{2} = D;
IMGs{2} = I;

input('Press Enter to Capture v2: \n');
[D, I] = SENZ3D_takeScan(frames, crop_ratio, downsampleRatio);
REFs{3} = D;
IMGs{3} = I;

%% SAVE FILENAME
resourceFolderPath = mfilename('fullpath');
resourceFolderPath = strcat(resourceFolderPath(1:end-23), '..\resource\');
var_filepath = experiment_generateExpSetFilepath( CameraType, WithMovement, ChangeType, resourceFolderPath );
save(var_filepath,	'REFs', ...
										'IMGs',	...
										'ROMIref',	...
										'ROMIthis',	...
										'SURF',	...
										'names'	...
									);
%% finish
fprintf('Experiment Resource stored at:\n\t%s\n', var_filepath);
clear