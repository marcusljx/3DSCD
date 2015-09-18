clear
clc
frames = 5;
cropRatio = 0.5;
downsizeRatio = 1;
mls_h = 15;

%% BEFORE - CAPTURE AND PREPROCESS
input('Press Enter to capture 1st.');
[ before_DD, before_I ] = Senz3D_capture_nFrames( frames );
[M,N,~] = size(before_DD);
small_M = cropRatio * M;
small_N = cropRatio * N;
before_nDD = [];

for i=1:frames
	before_nDD = cat(3, before_nDD, resizem(cropDepthMap(before_DD(:,:,i), small_N, small_M), 1));
end

%% CALC MLS AND AVG
before_aD = mean(before_nDD,3);
before_mD = mls_multiframeCapture( before_nDD, mls_h );

%% 
% 
% 
%

%% AFTER - CAPTURE AND PREPROCESS
input('Press Enter to capture 2nd.');
[ after_DD, after_I ] = Senz3D_capture_nFrames( frames );
[M,N,~] = size(after_DD);
small_M = cropRatio * M;
small_N = cropRatio * N;
after_nDD = [];

for i=1:frames
	after_nDD = cat(3, after_nDD, resizem(cropDepthMap(after_DD(:,:,i), small_N, small_M), 1));
end

%% CALC MLS AND AVG
after_aD = mean(after_nDD,3);
after_mD = mls_multiframeCapture( after_nDD, mls_h );

%% 
% 
% 
%

%% FIND DEVIANCES
fig_avg = figure;
s01_showChange( fig_avg, before_aD, after_aD, before_I, after_I, cropRatio );

fig_mls = figure;
s01_showChange( fig_mls, before_mD, after_mD, before_I, after_I, cropRatio );