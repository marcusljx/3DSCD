clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));

%% CAPTURE LONG_AVERAGE_1 AND LONG_AVERAGE_2
frames_for_capture = 50;
crop_scale = 0.5;	%DO NOT CHANGE
sizeX = crop_scale*320; sizeY = crop_scale*240;

[D1, D2, I1, I2] = Senz3D_capture_long2( frames_for_capture, crop_scale );
ND1 = cropDepthMap(D1, sizeX, sizeY);
ND2 = cropDepthMap(D2, sizeX, sizeY);

%% downsample ND1 & ND2
downsample_scale = 0.5;
downND1 = resizem(ND1, downsample_scale);
downND2 = resizem(ND2, downsample_scale);

%% find feature map
FD1 = fourSquareFeatureMap(downND1);
FD2 = fourSquareFeatureMap(downND2);

%% GET DIRECT DIFFERENCE & deviance showcase
fig_main = figure;

dev_DM = abs(downND1 - downND2);
maxDEV = max(max(dev_DM));
minDEV = min(min(dev_DM));

F_dev_DM = abs(FD1 - FD2);
F_maxDEV = max(max(F_dev_DM));
F_minDEV = min(min(F_dev_DM));

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

subplot(2,3,[2,5]),	h3 = imshow(imresize(dev_DM,3), [minDEV maxDEV]);
	colormap('jet'); title('Direct difference');
	
subplot(2,3,[3,6]),	h4 = imshow(imresize(F_dev_DM,3), [F_minDEV F_maxDEV]);
	colormap('jet'); title('Feature difference');