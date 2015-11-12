resourceFilePath = strcat('/home/aparra/marcus/3DSCD_20151022A/Pipeline/EXPERIMENT/resource/', filename);
resultFilePath = strcat('/home/aparra/marcus/3DSCD_20151022A/Pipeline/EXPERIMENT/result/', filename);

%% GLOBALS (DO NOT MODIFY)
mls_h = 3.0;
icp_tol = 1e-4;
fn = 3;

%% LOAD RESOURCE FILE
load(resourceFilePath);

%% PREPROCESSING ON SURF{1}
% tic
% disp('## Preproc: Performing Occ-MLS-interpolate on SURF{1}...');
% surf_P = depth2OrganizedPointCloud(SURF{1});
% [nPsurf, npsurf, M, N] = shiftIntoLargerFrame(surf_P,surf_P);
% SURF{1} = mls_occlude_interpolate(nPsurf, M,N, mls_h); disp('SURF{1} Complete'); toc
% disp('==============================');

%% PERFORM LOOP
for i=1:fn-1
	D1 = SURF{i};	%D1=gridMLS(D1,mls_h);	%testing?
	D2 = REFs{i+1}; %D2=gridMLS(D2,mls_h);
	[ ROMI_ref, ROMI_this ] = experiment_compare2surfaces( D1, D2, mls_h, icp_tol );
	ROMIref{i+1} = ROMI_ref;
	ROMIthis{i+1} = ROMI_this;
	
	%% COMBINE SURFACE
	surface = combineSurfaces(ROMI_ref, ROMI_this);
	SURF{i+1} = surface;
	
	disp('==============================');
end

save(resultFilePath);

% experiment_resultViewer(filename, 0.9);
% experiment_resultViewer(filename, 0.8);
% experiment_resultViewer(filename, 0.7);
% experiment_resultViewer(filename, 0.6);
% experiment_resultViewer(filename, 0.5);