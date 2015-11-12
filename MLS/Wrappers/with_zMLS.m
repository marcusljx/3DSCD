clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));

%% CAPTURE LONG_AVERAGE_1 AND LONG_AVERAGE_2
frames_for_capture = 20;
crop_scale = 0.5;
sizeX = crop_scale*320; sizeY = crop_scale*240;
downsample_gridstep = 10;

[D1, D2, I1, I2] = Senz3D_capture_long2( frames_for_capture, crop_scale );
ND1 = cropDepthMap(D1, sizeX, sizeY);
ND2 = cropDepthMap(D2, sizeX, sizeY);

% downsample ND1 & ND2
downsample_scale = 0.5;
downND1 = resizem(ND1, downsample_scale);
downND2 = resizem(ND2, downsample_scale);

P1 = NA_d2OPC(ND1);
P2 = NA_d2OPC(ND2);

dP1 = NA_d2OPC(downND1);
dP2 = NA_d2OPC(downND2);

%			ERROR CHECKING
			if ( size(dP1,1) ~= size(dP2,1) )
				error('ERROR: P1 & P2 dimensions do not match. Possible reflective item. ');
			end
%% MLS P1 & P2
mls_h = 15;
nn_dist = 30;
disp('running mls on P1..'); 
mlsP1 = runMLS_3D_localised_z(dP1, mls_h, nn_dist); disp('mlsP1 complete.');

disp('running mls on P2..'); 
mlsP2 = runMLS_3D_localised_z(dP2, mls_h, nn_dist); disp('mlsP2 complete.');
			
%% GET MLS DIFFERENCE & deviance showcase
mls_deviance_OPC = OPC_diff( mlsP1, mlsP2 );
[newM, newN] = size(downND1);
mls_dev_DM = OPC2_DepthMap(mls_deviance_OPC, newM, newN);

mls_dev_DM = rot90(mls_dev_DM,2);
maxDEV = max(max(mls_dev_DM));
minDEV = min(min(mls_dev_DM));
%% PLOT
x_box = [	(0.5*crop_scale * 320), ...
					640 - (0.5*crop_scale * 320), ...
					(0.5*crop_scale * 240), ...
					480 - (0.5*crop_scale * 240)
				];	% [x_begin, x_end, y_begin, y_end]
x_colorbox = [x_box(1), x_box(3), x_box(2)-x_box(1), x_box(4)-x_box(3)];

fig_main = figure;

subplot(2,3,1), imshow(I1); title('Before');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;

subplot(2,3,4), imshow(I2); title('After');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;

subplot(2,3,2), showPointCloud(mlsP1, 'r'); hold on; showPointCloud(mlsP2, 'b'); title('raw point clouds');
subplot(2,3,5), showPointCloud(mls_deviance_OPC); title('Deviation pointcloud');

subplot(2,3,6),	h6 = imshow(imresize(mls_dev_DM,3), [minDEV maxDEV]);
	colormap('jet'); title('Deviations under MLS');
	
%% GET DIRECT DIFFERENCE & deviance showcase
deviance_OPC = OPC_diff( P1, P2 );
dev_DM = OPC2_DepthMap(deviance_OPC, sizeY, sizeX);

dev_DM = rot90(dev_DM,2);
maxDEV = max(max(dev_DM));
minDEV = min(min(dev_DM));

subplot(2,3,3),	h3 = imshow(dev_DM, [minDEV maxDEV]);
	colormap('jet'); title('Direct difference');