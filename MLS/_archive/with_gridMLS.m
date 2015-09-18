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

%% MLS ND1 & ND2
mls_h = 15;
disp('running mls on ND1..'); 
tic
mlsND1 = gridMLS( downND1, mls_h ); disp('mlsND1 complete.');toc

disp('running mls on ND2..'); 
tic
mlsND2 = gridMLS( downND2, mls_h ); disp('mlsND2 complete.');toc
			
%% GET MLS DIFFERENCE & deviance showcase
mls_dev_DM = abs(mlsND1 - mlsND2);
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

subplot(2,3,[3,6]),	h6 = imshow(imresize(mls_dev_DM,3), [minDEV maxDEV]);
	colormap('jet'); title('Deviations under MLS');
	
%% GET DIRECT DIFFERENCE & deviance showcase
dev_DM = abs(downND1 - downND2);

maxDEV = max(max(dev_DM));
minDEV = min(min(dev_DM));

subplot(2,3,[2,5]),	h3 = imshow(imresize(dev_DM,3), [minDEV maxDEV]);
	colormap('jet'); title('Direct difference');