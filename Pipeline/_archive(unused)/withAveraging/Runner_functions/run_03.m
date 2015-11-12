function [dev, vq1, vq2] = run_03( d1, d2 )
	%% CONVERT TO POINTCLOUD
	P1 = depth2OrganizedPointCloud(d1);
	P2 = depth2OrganizedPointCloud(d2);

	%% ICP REGISTERATION
	icp_tol = 1e-2;
	disp('## run_03: Performing ICP...');
	[ FP1, FP2 ] = icp_reg( P1, P2, icp_tol );
	disp('## run_03: ICP Registration Complete.');

	%% INTERPOLATE SPARSE DATA ACROSS GRID
	mesh_gridspacing = 1;
	[outputsize_X, outputsize_Y] = size(d1);
	[~, ~, vq1] = scatteredOPC_2_mesh( FP1 , mesh_gridspacing, outputsize_X, outputsize_Y );
	[~, ~, vq2] = scatteredOPC_2_mesh( FP2 , mesh_gridspacing, outputsize_X, outputsize_Y );

	%% MLS ON INTERPOLATED POINTS
	mls_h = 15;
	disp('## run_03: running mls on vq1..'); tic
	mlsVQ1 = gridMLS( vq1, mls_h ); disp('## run_03: mlsVQ1 complete.');toc

	disp('## run_03: running mls on vq2..'); tic
	mlsVQ2 = gridMLS( vq2, mls_h ); disp('## run_03: mlsVQ2 complete.');toc

	%% DEVIANCE DETECTION
	dev = abs(mlsVQ1 - mlsVQ2);
	dev = fliplr(rot90(dev,1));
	disp('==============================================');
end