% runs crossMLS on both dataset 1 and 2, and compares their differences
function [ x_mlsNS1, x_mlsNS2, dev_DM, maxDEV, minDEV ] = runDev_crossMLS( dataset1, dataset2, h )
	% PERFORM cross MLS
	disp('running x_mls on set1..'); 
	tic
	x_mlsNS1 = crossMLS( dataset1, h ); disp('x_mlsNS1 complete.');toc

	disp('running x_mls on set2..'); 
	tic
	x_mlsNS2 = crossMLS( dataset2, h ); disp('x_mlsNS2 complete.');toc
	
	% GET MLS DIFF
	dev_DM = abs(x_mlsNS1 - x_mlsNS2);
	maxDEV = max(max(dev_DM));
	minDEV = min(min(dev_DM));
end

