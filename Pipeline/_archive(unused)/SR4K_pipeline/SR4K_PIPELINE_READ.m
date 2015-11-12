clc
clear

%% GLOBALS
downsampleRatio = 1;
crop_ratio = 0.5;
cropWidth = round(176 * crop_ratio);
cropHeight = round(144 * crop_ratio);

%% READ IN ALL SCANS
scanFilesPrefixes = {	'20150914ref',	...
											'20150914scan1NoDriftWithChange',	...
											'20150914scan2NoDriftWithChange',	...
											'20150914scan3NoDriftWithChange',	...
											'20150914scan4NoDriftWithChange',	...
                        };
fn = size(scanFilesPrefixes,2);

%preallocate storage
REFs{fn} = [];
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
	
	REFs{i} = imresize( D.*C, downsampleRatio );
  	
	if (i==1)
		SURF{1} = REFs{1};
	end
end
clear CD D X Y A C cropHeight crop_ratio cropWidth downsampleRatio i;