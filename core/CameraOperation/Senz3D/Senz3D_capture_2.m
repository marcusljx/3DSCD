function [ p1, p2 , I1, I2] = Senz3D_capture_2( )
% 	fig_cam = figure; 
	
	CameraHandle = pxcOpenCamera();
	if(CameraHandle == 0)
		error('no valid camera handle');
	end
	input('Press Enter to Capture 1:\n');
	pxcAcquireFrame(CameraHandle);
	D1 = pxcDepthImage(CameraHandle); D1=permute(D1,[2 1]);
	I1 = pxcColorImage(CameraHandle); I1=permute(I1([3,2,1],:,:),[3 2 1]);
	pxcReleaseFrame(CameraHandle);
	p1 = depth2OrganizedPointCloud(D1);
	pxcCloseCamera(CameraHandle);
	
% 	subplot(1,2,1), h1 = showPointCloud(p1);
	
	
	input('Press Enter to Capture 2:\n');
	
	CameraHandle = pxcOpenCamera();
	fprintf('Taking second shot..\n');
	pxcAcquireFrame(CameraHandle);
	D2 = pxcDepthImage(CameraHandle); D2=permute(D2,[2 1]);
	I2 = pxcColorImage(CameraHandle); I2=permute(I2([3,2,1],:,:),[3 2 1]);
	pxcReleaseFrame(CameraHandle);
	p2 = depth2OrganizedPointCloud(D2);
	pxcCloseCamera(CameraHandle);

% 	subplot(1,2,2), h2 = showPointCloud(p2);
	
end

