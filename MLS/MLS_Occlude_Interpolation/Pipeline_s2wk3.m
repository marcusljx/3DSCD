clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));

%% OBTAIN INITIAL SCANS
nFrames = 20;
crop_scale = 0.5;	%default
downsample_scale = 0.7; %default
[I1,I2, D1,D2, dND1,dND2, P1,FP2] = Pipeline_init_and_register(nFrames, crop_scale, downsample_scale);
[M,N] = size(dND1);

%% PERFORM OCCLUSION_MLS_INTERPOLATION ON FP2
mls_h = 15;
disp('Performing Occ-MLS-interpolate on FP2'); tic
DP2 = mls_occlude_interpolate(FP2, M,N, mls_h); disp('DP2 Complete'); toc
DP2 = rot90(DP2,2);
DP2 = invertArrayValues(DP2);

%% SUBSTITUTE OCCLUSION MASK ONTO VIEW 1
DP1 = dND1 + DP2 - DP2;
			
%% GRID-MLS ON DP1 // TODO: check mls procedure on DP1
disp('Performing MLS on DP1'); tic
mlsDP1 = gridMLS(DP1, mls_h); disp('mlsDP1 Complete'); toc

			%% PLOT DEBUG 1
% 			fig_debug = figure;
% 			subplot(2,4,1), hI1=imshow(I1); title('I1');
% 			subplot(2,4,5), hI2=imshow(I2); title('I2');
% 			subplot(2,4,2), hdND1=imshow(dND1, [min(min(dND1)),max(max(dND1))]); title('dND1');
% 			subplot(2,4,6), hdND2=imshow(dND2, [min(min(dND2)),max(max(dND2))]); title('dND2');
% 			subplot(2,4,3), hDP1 =imshow(mlsDP1, [min(min(mlsDP1)),max(max(mlsDP1))]); title('mlsDP1');
% 			subplot(2,4,7), hDP2 =imshow(DP2, [min(min(DP2)),max(max(DP2))]); title('DP2');
% 			colormap('jet');
			
%% FIND DIFFERENCE
dev = abs(mlsDP1 - DP2);

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
subplot(2,3,2), hV1=imshow(mlsDP1, [min(min(mlsDP1)),max(max(mlsDP1))]); title('(before) + 2D-MLS');
subplot(2,3,5), hV2=imshow(DP2, [min(min(DP2)),max(max(DP2))]); title('(after) Registered + Occlusion Hiding + 2.5D-MLS');
subplot(2,3,[3,6]), hdev=imshow(dev, [min(min(dev)),max(max(dev))]); title('Simple Deviation');
colormap('jet');