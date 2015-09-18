clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));

%% CAPTURE SET_1 AND SET_2
frames_for_capture = 2;
crop_scale = 0.5;	%DO NOT CHANGE
sizeX = crop_scale*320; sizeY = crop_scale*240;

	input('Press Enter to Capture Set 1:\n');
		[ S1, I1 ] = Senz3D_capture_nFrames( frames_for_capture );
	input('Press Enter to Capture Set 2:\n');
		[ S2, I2 ] = Senz3D_capture_nFrames( frames_for_capture  );

NS1 = cropDepthSet(S1, sizeX, sizeY);
NS2 = cropDepthSet(S2, sizeX, sizeY);

%% downsample NS1 & NS2
downsample_scale = 0.1;

downNS1 = [];
downNS2 = [];
for i=1:frames_for_capture
	downNS1 = cat(3, downNS1, resizem(NS1(:,:,i), downsample_scale) );
	downNS2 = cat(3, downNS2, resizem(NS2(:,:,i), downsample_scale) );
end

%% PERFORM CROSS MLS
mls_h = 15;
disp('running x_mls on NS1..'); 
tic
x_mlsNS1 = crossMLS( downNS1, mls_h ); disp('x_mlsNS1 complete.');toc

disp('running x_mls on NS2..'); 
tic
x_mlsNS2 = crossMLS( downNS2, mls_h ); disp('x_mlsNS2 complete.');toc
			
%% GET MLS DIFF
xmls_dev_DM = abs(x_mlsNS1 - x_mlsNS2);
xmls_maxDEV = max(max(xmls_dev_DM));
xmls_minDEV = min(min(xmls_dev_DM));

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

subplot(2,3,[3,6]),	h6 = imshow(imresize(xmls_dev_DM,3), [xmls_minDEV xmls_maxDEV]);
	colormap('jet'); title('Deviations under MLS');
	
%% GET DIRECT DIFFERENCE & deviance showcase
dev_DM = abs(downND1 - downND2);

maxDEV = max(max(dev_DM));
minDEV = min(min(dev_DM));

subplot(2,3,[2,5]),	h3 = imshow(imresize(dev_DM,3), [minDEV maxDEV]);
	colormap('jet'); title('Direct difference');