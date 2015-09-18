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
ROMIref{fn} = [];
ROMIthis{fn} = [];
SURF{fn} = [];

for i=1:fn
	[~, ~, D, C] = SR4K_readScan( scanFilesPrefixes{i}, cropWidth, cropHeight );
	CD = imresize( D .* C, downsampleRatio );
	REFs{i} = CD;
	if (i==1)
		SURF{1} = CD;
	end
end
clear CD C D;