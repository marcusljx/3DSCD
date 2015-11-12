function [ ROMI_ref, ROMI_this ] = SR4K_compare2surfaces( D1, D2, mls_h, icp_tol )
	ref_P = depth2OrganizedPointCloud(D1);
	this_P = depth2OrganizedPointCloud(D2);

	%% CO-REGISTRATION
	fprintf('Registering Current View onto Reference View...')
	this_P = icp_reg(this_P, ref_P, icp_tol);
	disp('Registered.');
	
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

