frames = 20;
fig_main = figure;

[ D, I ] = Senz3D_capture_nFrames_avg( frames );
subplot(1,3,1), h1=imshow(I);
subplot(1,3,2), h2=imshow(D,[min(min(D)),max(max(D))]);

ndm = resizem(cropDepthMap(D, 240, 180), 0.5);

subplot(1,3,3), h3=surf(ndm);
colormap('jet');

while(ishandle(fig_main))
	[ D, I ] = Senz3D_capture_nFrames_avg( frames );
	ndm = resizem(cropDepthMap(D, 240, 180), 0.5);
	
	set(h1,'CDATA',I);
	set(h2,'CDATA',D);
	set(h3,'ZDATA',ndm);
	drawnow;
end