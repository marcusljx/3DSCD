clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));
%% TAKE SNAPSHOTS
frames = 20;
crop_scale = 0.5;
disp('Initialising..');

[D1,D2, I1,I2] = Senz3D_capture_long2( frames );

%% CROP AND DOWNSAMPLE
sizeX = crop_scale*320; 
sizeY = crop_scale*240;
ND1 = cropDepthMap(D1, sizeX, sizeY);
ND2 = cropDepthMap(D2, sizeX, sizeY);

downsample_scale = 0.5;
downND1 = resizem(ND1, downsample_scale);
downND2 = resizem(ND2, downsample_scale);

%% CONVERT TO POINTCLOUD
P1 = depth2OrganizedPointCloud(downND1);
P2 = depth2OrganizedPointCloud(downND2);

%% MLS BEFORE ICP
mls_h = 15;
nn_dist = 30;
disp('Performing mlsP1..');tic
mlsP1 = runMLS_3D_localised( P1, mls_h, nn_dist ); disp('mlsP1 Complete.');toc
disp('Performing mlsP2..');tic
mlsP2 = runMLS_3D_localised( P2, mls_h, nn_dist ); disp('mlsP2 Complete.');toc

%% ICP REGISTRATION
icp_tol = 1e-2;
disp('Performing ICP...');
[ FP1, FP2 ] = icp_reg( mlsP1, mlsP2, icp_tol );
disp('ICP Registration Complete.');

%% INTERPOLATE SPARSE DATA ACROSS GRID
mesh_gridspacing = 1;
[outputsize_X, outputsize_Y] = size(downND1);
[xq1, yq1, vq1] = scatteredOPC_2_mesh( FP1 , mesh_gridspacing, outputsize_X, outputsize_Y );
[xq2, yq2, vq2] = scatteredOPC_2_mesh( FP2 , mesh_gridspacing, outputsize_X, outputsize_Y );

%% DEVIANCE DETECTION
dev = abs(vq1 - vq2);
dev = fliplr(rot90(dev,1));
max_dev = max(max(dev));
min_dev = min(min(dev));

%% PLOT
x_box = [	(0.5*crop_scale * 320), ...
					640 - (0.5*crop_scale * 320), ...
					(0.5*crop_scale * 240), ...
					480 - (0.5*crop_scale * 240)
				];	% [x_begin, x_end, y_begin, y_end]
x_colorbox = [x_box(1), x_box(3), x_box(2)-x_box(1), x_box(4)-x_box(3)];

fig_main = figure;
subplot(2,4,1), h1=imshow(I1); title('Before');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;
subplot(2,4,2), h2=showPointCloud(P1); title('P1');

subplot(2,4,5), h5=imshow(I2); title('After');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;
subplot(2,4,6), h6=showPointCloud(P2); title('P2');

subplot(2,4,3), showPointCloud(FP1, 'r'), hold on, showPointCloud(FP2, 'b'); title('ICP'); hold off;

subplot(2,4,7), mesh(xq1,yq1,vq1), hold on, mesh(xq2,yq2,vq2); title('meshes'); hold off;
subplot(2,4,[4,8]), hdev= imshow(imresize(dev,3), [min_dev, max_dev]);
	colormap('jet'); title('MLS + ICP + interpolated deviance');