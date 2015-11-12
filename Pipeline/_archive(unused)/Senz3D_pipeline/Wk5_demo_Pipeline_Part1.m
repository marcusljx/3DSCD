%% DEMO GLOBALS
frames_per_capture = 20;
mls_h = 15;
SurfaceStoragePath = 'F:\Matlab_Home_HonsLab_sync\PIPELINE_program\ReferenceSurfaces\demo_ref';

%% TAKE REFERENCE SCAN
input('Press Enter to Capture Reference Scan: \n');
[ref, ~, I] = A_createReferenceScan( frames_per_capture, SurfaceStoragePath, mls_h );
fprintf('Reference scan stored at:\n%s\n', SurfaceStoragePath);

subplot(3,noc,e), imshow(I); title('I\_ref');
subplot(3,noc,2*noc+e), show_depthmap_relative(ref); title('combined\_ref');
