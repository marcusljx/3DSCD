clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));

%% CAPTURE LONG_AVERAGE_1 AND LONG_AVERAGE_2
frames_for_capture = 20;
crop_scale = 0.5;
sizeX = crop_scale*320; sizeY = crop_scale*240;

[D1, D2, I1, I2] = Senz3D_capture_long2( frames_for_capture, crop_scale );
ND1 = cropDepthMap(D1, sizeX, sizeY);
ND2 = cropDepthMap(D2, sizeX, sizeY);
P1 = NA_d2OPC(ND1);
P2 = NA_d2OPC(ND2);

%			ERROR CHECKING
			if ( size(P1,1) ~= ((crop_scale^2)*320*240) )
				error('ERROR: Possible reflective item in scene 1');
			elseif ( size(P2,1) ~= ((crop_scale^2)*320*240) )
				error('ERROR: Possible reflective item in scene 2');
			end
			
%% GET DIRECT DIFFERENCE & deviance showcase
deviance_OPC = OPC_diff( P1, P2 );
dev_DM = OPC2_DepthMap(deviance_OPC, sizeX, sizeY);

dev_DM = rot90(dev_DM,2);
maxDEV = max(max(dev_DM));
minDEV = min(min(dev_DM));
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

subplot(2,3,2), showPointCloud(P1, 'r'); hold on; showPointCloud(P2, 'b'); title('raw point clouds');
subplot(2,3,5), showPointCloud(deviance_OPC); title('Deviation pointcloud');

subplot(2,3,[3,6]),	h6 = imshow(imresize(dev_DM,3), [minDEV maxDEV]);
	colormap('jet'); title('Deviations');