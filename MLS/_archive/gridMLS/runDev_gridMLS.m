% runs gridMLS on both grids 1 and 2, and compares their differences
function [ g_mlsND1, g_mlsND2, dev_DM, maxDEV, minDEV ] = runDev_gridMLS( D1, D2, h )
	% PERFORM cross MLS
	disp('running gridmls on D1..'); 
	tic
	g_mlsND1 = gridMLS( D1, h ); disp('mlsND1 complete.');toc

	disp('running gridmls on D2..'); 
	tic
	g_mlsND2 = gridMLS( D2, h ); disp('mlsND2 complete.');toc

	%% GET MLS DIFFERENCE & deviance showcase
	dev_DM = abs(g_mlsND1 - g_mlsND2);
	maxDEV = max(max(dev_DM));
	minDEV = min(min(dev_DM));

end

