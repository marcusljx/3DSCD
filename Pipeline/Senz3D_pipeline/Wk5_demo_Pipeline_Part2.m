%% INIT
SurfaceStoragePath = 'F:\Matlab_Home_HonsLab_sync\PIPELINE_program\ReferenceSurfaces\demo_ref';
load(SurfaceStoragePath);

%% TAKE MULTIPLE SCANS AND COMPARE
input('Press Enter to Capture and Compare Scan: ');
[ this_dND, this_I, curr_grid, ref_grid ] = B_compareNextScan(SurfaceStoragePath);	

%% SHOW CHANGES
% fig_main = figure;
% dev = s01_showChange( fig_main, ref_grid, curr_grid, latest_I, this_I, crop_scale );

%debug: show shift
% [M,N] = size(ref_grid);
% show_shiftIntoLargerFrame( ref_grid, this_dND,curr_grid, M, N );

% MERGE-UPDATE
s02_updateRefData(SurfaceStoragePath, ref_grid, curr_grid, this_I);