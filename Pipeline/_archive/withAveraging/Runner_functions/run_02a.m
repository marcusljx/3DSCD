function [dev, vq1, vq2] = run_02a( d1, d2 )
	%% CONVERT TO POINTCLOUD
	P1 = depth2OrganizedPointCloud(d1);
	P2 = depth2OrganizedPointCloud(d2);

	%% MLS BEFORE ICP
	mls_h = 15;
	nn_dist = 30;
	disp('## run_02a: Performing mlsP1..');tic
	mlsP1 = runMLS_3D_localised( P1, mls_h, nn_dist ); disp('## run_02a: mlsP1 Complete.');toc
	disp('## run_02a: Performing mlsP2..');tic
	mlsP2 = runMLS_3D_localised( P2, mls_h, nn_dist ); disp('## run_02a: mlsP2 Complete.');toc

	%% ICP REGISTRATION
	icp_tol = 1e-2;
	disp('## run_02a: Performing ICP...');
	[ FP1, FP2 ] = icp_reg( mlsP1, mlsP2, icp_tol );
	disp('## run_02a: ICP Registration Complete.');

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