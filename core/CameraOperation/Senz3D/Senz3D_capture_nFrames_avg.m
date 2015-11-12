%SENZ3D_CAPTURENFRAMES Takes N shots over time and returns average depth map

function [ D, I ] = Senz3D_capture_nFrames_avg( N )
	CameraHandle = pxcOpenCamera();
	if(CameraHandle == 0)
		error('no valid camera handle');
	end
	
	pxcAcquireFrame(CameraHandle);
	d = pxcDepthImage(CameraHandle); d=permute(d,[2 1]);
	D = d;
	I = pxcColorImage(CameraHandle); I=permute(I([3,2,1],:,:),[3 2 1]);
	pxcReleaseFrame(CameraHandle);
	
	for i=1:N;
		fprintf('Capturing frame %i\n', i);
		pxcAcquireFrame(CameraHandle);
		d = pxcDepthImage(CameraHandle); d=permute(d,[2 1]);
		D = (D + d) ./ 2;
% 		I1 = pxcColorImage(CameraHandle); I1=permute(I1([3,2,1],:,:),[3 2 1]);
		pxcReleaseFrame(CameraHandle);
	end
	
	pxcCloseCamera(CameraHandle);
end