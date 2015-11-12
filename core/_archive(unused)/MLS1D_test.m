clear
clc
frames = 5;
cropRatio = 0.5;
downsizeRatio = 1;

[ DD, I ] = Senz3D_capture_nFrames( frames );
[M,N,K] = size(DD);
small_M = cropRatio * M;
small_N = cropRatio * N;
nDD = [];

%% CROP FRAMES
for i=1:frames
	nDD = cat(3, nDD, resizem(cropDepthMap(DD(:,:,i), small_N, small_M), 1));
end

aD = mean(nDD,3);
mD = zeros(small_M, small_N);

disp('doing mls1D on input scans'); tic
%% CODUCT MLS1D ON 1 POINT
for i = 1:small_M
	parfor j = 1:small_N;
		P = squeeze(nDD(i,j,:));
		r = mean(P);
		t = 0;	%initial t
		h = 20;

		t = fminbnd(@(t) objectiveFunc_mls1D(t, P, r, h),	...
									(-h/2), (h/2) );

		mD(i,j) = r+t;
	end
	fprintf('i=%i complete.\n', i);
end
disp('mls1D complete'); toc

%% PLOT COMPARISON
fig_main = figure;
subplot(2,3,1), hI=imshow(I);
subplot(2,3,2), hDa=imshow(aD, [min(min(aD)), max(max(aD))]); title('avg');
subplot(2,3,5), hDm=imshow(mD, [min(min(mD)), max(max(mD))]); title('mls');

subplot(2,3,3), hSa=surf(aD); title('avg');
subplot(2,3,6), hSm=surf(mD); title('mls');
colormap('jet');