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

%% APPLY RUN_01
[dev_01, vq1_01, vq2_01] = run_01(downND1,downND2);
max_dev_01 = max(max(dev_01));
min_dev_01 = min(min(dev_01));

%% APPLY RUN_02a
[dev_02a, vq1_02a, vq2_02a] = run_02a(downND1,downND2);
max_dev_02a = max(max(dev_02a));
min_dev_02a = min(min(dev_02a));

%% APPLY RUN_02b
[dev_02b, vq1_02b, vq2_02b] = run_02b(downND1,downND2);
max_dev_02b = max(max(dev_02b));
min_dev_02b = min(min(dev_02b));

%% APPLY RUN_03
[dev_03, vq1_03, vq2_03] = run_03(downND1,downND2);
max_dev_03 = max(max(dev_03));
min_dev_03 = min(min(dev_03));

%% PLOT
x_box = [	(0.5*crop_scale * 320), ...
					640 - (0.5*crop_scale * 320), ...
					(0.5*crop_scale * 240), ...
					480 - (0.5*crop_scale * 240)
				];	% [x_begin, x_end, y_begin, y_end]
x_colorbox = [x_box(1), x_box(3), x_box(2)-x_box(1), x_box(4)-x_box(3)];

fig_main = figure;
subplot(2,3,1), h1=imshow(I1); title('Before');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;

subplot(2,3,4), h2=imshow(I2); title('After');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;

subplot(2,3,2), hd1= imshow(imresize(dev_01,3), [min_dev_01, max_dev_01]); 
	title('01: ICP + interpolated deviance');
	
subplot(2,3,3), hd2a= imshow(imresize(dev_02,3), [min_dev_02, max_dev_02]); 
	title('02a: 3DMLS + ICP + interpolated deviance');
	
subplot(2,3,5), hd2b= imshow(imresize(dev_02b,3), [min_dev_02b, max_dev_02b]); 
	title('02b: gridMLS + ICP + interpolated deviance');
	
subplot(2,3,6), hd3= imshow(imresize(dev_03,3), [min_dev_03, max_dev_03]); 
	title('03: ICP + interpolated MLS deviance');
	
colormap('jet');