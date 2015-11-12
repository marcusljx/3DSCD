mls_h = 0.5;
icp_tol = 1e-3;
for i=1:fn-1
	[ ROMI_ref, ROMI_this ] = SR4K_compare2surfaces( SURF{i}, REFs{i+1}, mls_h, icp_tol );
	ROMIref{i+1} = ROMI_ref;
	ROMIthis{i+1} = ROMI_this;
	%% FIND DIFFERENCE
% 	dev = dDiff(ROMI_ref, ROMI_this, 'standard');
% 	DIFF{i+1} = dev;6
	
	%% COMBINE SURFACE
	surface = combineSurfaces(ROMI_ref, ROMI_this);
	SURF{i+1} = surface;
	
	disp('==============================');
end

fig = view_RDS( AA, REFs, ROMIref, ROMIthis, SURF, scanFilesPrefixes, 'combined_std', 'relative');