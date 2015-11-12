%S02_COMPARENEXTSCAN Summary of this function goes here
%   Detailed explanation goes here

function [ this_dND, this_I, this_grid_surface, ref_grid_surface] = B_compareNextScan( refFilePath )
	%% LOAD REFERENCE FILE
	load(refFilePath);	% 'frames', 'ref_grid_surface', 'latest_I', 'crop_scale', 'downsample_scale', 'mls_h'
	disp('Reference File...Loaded.');
	
	%% GRAB FRAME
	[this_dND, ~, this_I] = s00_takeScan(frames, crop_scale, downsample_scale);
	
	%% PREPROCESSING
	ref_P = depth2OrganizedPointCloud(ref_grid_surface);
	this_P = depth2OrganizedPointCloud(this_dND);
	
	%% REGISTER!
	icp_tol = 1e-3;
	fprintf('Registering Current View onto Reference View...')
	this_P = icp_reg(this_P, ref_P, icp_tol);
	disp('Registered.');
	
	%% MIGRATE BOTH INTO LARGER REFERENCE FRAME
	disp('Shifting reference surface and current surface onto larger frame');
	[nPref, nPthis, M, N] = shiftIntoLargerFrame(ref_P, this_P);
	
	%% PERFORM OCCLUSION_MLS_INTERPOLATION ON BOTH CLOUDS
	tic
	disp('Performing Occ-MLS-interpolate on nPref');
	ref_grid_surface = mls_occlude_interpolate(nPref, M,N, mls_h); disp('ref_grid_surface Complete'); toc
	
	tic
	disp('Performing Occ-MLS-interpolate on nPthis');
	this_grid_surface = mls_occlude_interpolate(nPthis, M,N, mls_h); disp('this_grid_surface Complete'); toc
end

