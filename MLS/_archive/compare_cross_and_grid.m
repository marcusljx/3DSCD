clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));

%% CAPTURE SET_1 AND SET_2
frames_for_capture = 10;
crop_scale = 0.5;	%DO NOT CHANGE
sizeX = crop_scale*320; sizeY = crop_scale*240;

	input('Press Enter to Capture Set 1:\n');
		[ S1, I1 ] = Senz3D_capture_nFrames( frames_for_capture );
	input('Press Enter to Capture Set 2:\n');
		[ S2, I2 ] = Senz3D_capture_nFrames( frames_for_capture  );

NS1 = cropDepthSet(S1, sizeX, sizeY);
NS2 = cropDepthSet(S2, sizeX, sizeY);

%% downsample NS1 & NS2
downsample_scale = 0.5;

downNS1 = [];
downNS2 = [];
for i=1:frames_for_capture
	downNS1 = cat(3, downNS1, resizem(NS1(:,:,i), downsample_scale) );
	downNS2 = cat(3, downNS2, resizem(NS2(:,:,i), downsample_scale) );
end

mls_h = 15;
%% RUN STANDARD GRID AVERAGE
	downND1 = sum(downNS1,3)/frames_for_capture;
	downND2 = sum(downNS2,3)/frames_for_capture;
	
	[ g_mlsND1, g_mlsND2, g_dev_DM, g_maxDEV, g_minDEV ] = runDev_gridMLS( downND1, downND2, mls_h );
%% RUN CROSS MLS
	[ x_mlsNS1, x_mlsNS2, x_dev_DM, x_maxDEV, x_minDEV ] = runDev_crossMLS( downNS1, downNS2, mls_h );

%% FIND DIRECT DIFFERENCE
	d_dev_DM = abs( downND1 - downND2 );
	d_maxDEV = max(max(d_dev_DM));
	d_minDEV = min(min(d_dev_DM));
	
%% PLOT
x_box = [	(0.5*crop_scale * 320), ...
					640 - (0.5*crop_scale * 320), ...
					(0.5*crop_scale * 240), ...
					480 - (0.5*crop_scale * 240)
				];	% [x_begin, x_end, y_begin, y_end]
x_colorbox = [x_box(1), x_box(3), x_box(2)-x_box(1), x_box(4)-x_box(3)];

fig_main = figure;

subplot(3,6,[1:3]), imshow(I1); title('Before');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;

subplot(3,6,[4:6]), imshow(I2); title('After');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;

%plot direct difference
title1 = sprintf('Direct difference over average surface (%i frames)', frames_for_capture);
subplot(3,6,[7,8,13,14]), h1 = imshow(imresize(d_dev_DM,3), [d_minDEV d_maxDEV]);
	colormap('jet'); title(title1);

%plot average-mls difference
title2 = sprintf('Difference over MLS of average surface (%i frames)', frames_for_capture);
subplot(3,6,[9,10,15,16]), h2 = imshow(imresize(g_dev_DM,3), [g_minDEV g_maxDEV]);
	colormap('jet'); title(title2);

%plot cross-mls difference
title3 = sprintf('Difference over overlapped cross MLS of %i samples', frames_for_capture);
subplot(3,6,[11,12,17,18]),	h3 = imshow(imresize(x_dev_DM,3), [x_minDEV x_maxDEV]);
	colormap('jet'); title(title3);