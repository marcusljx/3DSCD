function [dev, d1, vq2] = run_01( d1, d2 )
	%% CONVERT TO POINTCLOUD
	P1 = depth2OrganizedPointCloud(d1);
	P2 = depth2OrganizedPointCloud(d2);
	
	%% ICP REGISTERATION
	icp_tol = 1e-2;
	disp('## run_01: Performing ICP...');
	FP2 = icp_reg( P2, P1, icp_tol );
	disp('## run_01: ICP Registration Complete.');

	%% INTERPOLATE SPARSE DATA ACROSS GRID
	disp('## run_01: Interpolating..')
	mesh_gridspacing = 1;
	[outputsize_X, outputsize_Y] = size(d1);
	[~, ~, vq2] = scatteredOPC_2_mesh( FP2 , mesh_gridspacing, outputsize_X, outputsize_Y );
	[~, ~, vq1] = scatteredOPC_2_mesh( P1 , mesh_gridspacing, outputsize_X, outputsize_Y );
	vq1 = fliplr(rot90(vq1,1));
	vq2 = fliplr(rot90(vq2,1));
	%% INVALIDATE OCCLUDED GHOST POINTS IN VQ2
	disp('## run_01: Removing Ghost Points..');
	vq2 = invalidate_occlusion(vq2, FP2);
	disp('Complete.');
	
	%% DEVIANCE DETECTION
	dev = abs(vq1 - vq2);
	disp('==============================================');
end