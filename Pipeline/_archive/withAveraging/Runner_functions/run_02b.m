function [dev, vq1, vq2] = run_02b( d1, d2 )
	%% GRID MLS
	mls_h = 15;
	disp('## run_02b: Performing gridmlsP1..');tic
	gridmlsP1 = gridMLS( d1, mls_h ); disp('## run_02b: gridmlsP1 Complete.');toc
	disp('## run_02b: Performing gridmlsP2..');tic
	gridmlsP2 = gridMLS( d2, mls_h ); disp('## run_02b: gridmlsP2 Complete.');toc


	%% CONVERT TO POINTCLOUD
	P1 = depth2OrganizedPointCloud(gridmlsP1);
	P2 = depth2OrganizedPointCloud(gridmlsP2);

	%% ICP REGISTRATION
	icp_tol = 1e-2;
	disp('## run_02b: Performing ICP...');
	[ FP1, FP2 ] = icp_reg( P1, P2, icp_tol );
	disp('## run_02b: ICP Registration Complete.');

	%% INTERPOLATE SPARSE DATA ACROSS GRID
	mesh_gridspacing = 1;
	[outputsize_X, outputsize_Y] = size(d1);
	[~, ~, vq1] = scatteredOPC_2_mesh( FP1 , mesh_gridspacing, outputsize_X, outputsize_Y );
	[~, ~, vq2] = scatteredOPC_2_mesh( FP2 , mesh_gridspacing, outputsize_X, outputsize_Y );

	%% DEVIANCE DETECTION
	dev = abs(vq1 - vq2);
	dev = fliplr(rot90(dev,1));
	disp('==============================================');
end

