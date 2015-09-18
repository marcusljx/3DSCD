function [ DD, I ] = Senz3D_capture_nFrames( N )
	CameraHandle = pxcOpenCamera();
	
	DD = repmat(zeros(240,320), 1,1, N);
	
	if(CameraHandle == 0)
		error('no valid camera handle');
	end
	
	pxcAcquireFrame(CameraHandle);
	d = pxcDepthImage(CameraHandle); d=permute(d,[2 1]);
	DD(:,:,1) = d;
	I = pxcColorImage(CameraHandle); I=permute(I([3,2,1],:,:),[3 2 1]);
	pxcReleaseFrame(CameraHandle);
	
	for i=2:N;
		fprintf('Capturing frame %i\n', i);
		pxcAcquireFrame(CameraHandle);
		d = pxcDepthImage(CameraHandle); d=permute(d,[2 1]);
		DD(:,:,i) = d;
% 		I1 = pxcColorImage(CameraHandle); I1=permute(I1([3,2,1],:,:),[3 2 1]);
		pxcReleaseFrame(CameraHandle);
	end
	
	pxcCloseCamera(CameraHandle);
end