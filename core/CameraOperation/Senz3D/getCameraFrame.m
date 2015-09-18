%% GETCAMERAFRAME Gets DEPTH and IMAGE data from a camera handle
%   snippet of SENZ3D MATLAB ACQUISITION INTERFACE
% 								by Dirk-Jan Kroon
%%
function [ D I ] = getCameraFrame( CameraHandle )
	pxcAcquireFrame(CameraHandle);

	D = pxcDepthImage(CameraHandle); D=permute(D,[2 1]);
	I = pxcColorImage(CameraHandle); I=permute(I([3,2,1],:,:),[3 2 1]);

	pxcReleaseFrame(CameraHandle);
end