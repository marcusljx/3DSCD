function [ ROMI_ref, ROMI_this ] = experiment_compare2surfaces( D1, D2, mls_h, icp_tol )
	ref_P = depth2OrganizedPointCloud(D1);
	this_P = depth2OrganizedPointCloud(D2);

	%% CO-REGISTRATION
	fprintf('Registering Current View onto Reference View...')
    tic
%     this_P = alvaro_6dof(this_P, ref_P);    % setting default translation box to 50
    this_P = icp_reg(this_P, ref_P, icp_tol);

% 	%use matlab's ICP registration (for checking)
% 	pc_ref = pointCloud(ref_P);
% 	pc_this = pointCloud(this_P);
% 	[ ~ , pc_this] = pcregrigid(pc_this, pc_ref);
% 	this_P = pc_this.Location;
	disp('Registered.');
	toc
	%% MIGRATE BOTH INTO LARGER REFERENCE FRAME
	disp('Shifting reference surface and current surface onto larger frame');
	[nPref, nPthis, M, N] = shiftIntoLargerFrame(ref_P, this_P);
	
	%% PERFORM OCCLUSION_MLS_INTERPOLATION ON BOTH CLOUDS
	tic
	disp('Performing Occ-MLS-interpolate on nPref');
	ROMI_ref = mls_occlude_interpolate(nPref, M,N, mls_h); disp('ROMI_ref Complete'); toc
	
	tic
	disp('Performing Occ-MLS-interpolate on nPthis');
	ROMI_this = mls_occlude_interpolate(nPthis, M,N, mls_h); disp('ROMI_this Complete'); toc
end