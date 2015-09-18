clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));

%% OBTAIN INITIAL SCANS
nFrames = 20;
crop_scale = 0.5;	%default
downsample_scale = 0.8; %default
[I1,I2, D1,D2, dND1,dND2, P1,FP2] = Pipeline_init_and_register(nFrames, crop_scale, downsample_scale);

%% PLOT DEBUG 1
% fig_debug = figure;
% subplot(2,4,1), hI1=imshow(I1); title('I1');
% subplot(2,4,5), hI2=imshow(I2); title('I2');
% subplot(2,4,2), hD1=imshow(D1, [min(min(D1)),max(max(D1))]); title('D1');
% subplot(2,4,6), hD2=imshow(D2, [min(min(D2)),max(max(D2))]); title('D2');
% subplot(2,4,3), hdND1=imshow(dND1, [min(min(dND1)),max(max(dND1))]); title('dND1');
% subplot(2,4,7), hdND2=imshow(dND2, [min(min(dND2)),max(max(dND2))]); title('dND2');
% subplot(2,4,[4,8]), hP1 =showPointCloud(P1, 'b'); hold on;
% 										hFP2=showPointCloud(FP2, 'r'); hold off;
% colormap('jet');

%% INTERPOLATE FP2 DATA ONTO P1 SPACE
[outSizeX, outSizeY] = size(dND1);

[xq1, yq1, vq1] = scatteredOPC_2_mesh(P1,1, outSizeX, outSizeY);
[xq2, yq2, vq2] = scatteredOPC_2_mesh(FP2,1, outSizeX, outSizeY);

%% PLOT DEBUG 2
% fig_debug2 = figure;
% subplot(2,2,1), hdND1=imshow(dND1, [min(min(dND1)),max(max(dND1))]); title('dND1');
% subplot(2,2,2), hdND2=imshow(dND2, [min(min(dND2)),max(max(dND2))]); title('dND2');
% subplot(2,2,3), hvq1=imshow(vq1, [min(min(vq1)),max(max(vq1))]); title('vq1');
% subplot(2,2,4), hvq2=imshow(vq2, [min(min(vq2)),max(max(vq2))]); title('vq2');
% colormap('jet');

%% INVALIDATE OCCLUSION OF VQ2 FROM FP2
sub_vq2 = rot90(fliplr(vq2),1);
invalid_dist = 0.5;
newVQ2 = invalidate_occlusion(sub_vq2, FP2, invalid_dist);

newVQ2 = rot90(newVQ2,2);
vq1 = rot90(fliplr(vq1),3);

%% DIFFERENCE NEWVQ WITH VQ1
dev = abs(vq1 - newVQ2);

%% PLOT DISPLAY
x_box = [	(0.5*crop_scale * 320), ...
					640 - (0.5*crop_scale * 320), ...
					(0.5*crop_scale * 240), ...
					480 - (0.5*crop_scale * 240)
				];	% [x_begin, x_end, y_begin, y_end]
x_colorbox = [x_box(1), x_box(3), x_box(2)-x_box(1), x_box(4)-x_box(3)];

fig_disp = figure;
subplot(2,3,1), imshow(I1); title('Before');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;
subplot(2,3,4), imshow(I2); title('After');hold on;
rectangle('position',x_colorbox, 'edgecolor','b'); hold off;
subplot(2,3,2), hvq1=imshow(vq1, [min(min(vq1)),max(max(vq1))]); title('(before)');
% subplot(2,3,3), hvq2=imshow(vq2, [min(min(vq2)),max(max(vq2))]); title('vq2');
subplot(2,3,5), hnewVQ2=imshow(newVQ2, [min(min(newVQ2)),max(max(newVQ2))]); title('(after) Registered + Occlusion Hiding');
subplot(2,3,[3,6]), hdev=imshow(dev, [min(min(dev)),max(max(dev))]); title('Simple Deviation');
colormap('jet');