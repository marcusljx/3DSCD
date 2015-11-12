filename = 'SENZ3D_N_0NoChange1.mat';
resourceFilePath = strcat(pwd,'\Pipeline\EXPERIMENT\resource\', filename);

%% GLOBALS (DO NOT MODIFY)
% mls_h = 3.0;
icp_tol = 1e-4;

for mls_h = 0.3:0.1:5.0

	%% LOAD RESOURCE FILE
	load(resourceFilePath);

	%% PERFORM LOOP
		i=1;
		D1 = SURF{i};	%D1=gridMLS(D1,mls_h);	%testing?
		D2 = REFs{i+1}; %D2=gridMLS(D2,mls_h);
		[ ROMI_ref, ROMI_this ] = experiment_compare2surfaces( D1, D2, mls_h, icp_tol );
		ROMIref{i+1} = ROMI_ref;
		ROMIthis{i+1} = ROMI_this;

		%% COMBINE SURFACE
		surface = combineSurfaces(ROMI_ref, ROMI_this);
		SURF{i+1} = surface;

		disp('==============================');

	resultFilePath = strcat(pwd,'\Pipeline\mls_Experiment\mls_exp_results\', num2str(mls_h), filename);
	save(resultFilePath);
	
	clearvars -except 'filename' 'resourceFilePath' 'icp_tol';
end