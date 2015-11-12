% This function pxcColorImage can be used to obtain the RGB-image from 
% the Senz3D camera.      
%
%  I = pxcColorImage(CameraHandle);
%
% inputs,
%   CameraHandle : Camera Handle to Senz3D camera
%   
% Ouputs,
%   I : RGB image (UInt8), note the dimensions are [RGB,Y,X] 
%
% Example,
% 	CameraHandle  = pxcOpenCamera();
%   pxcAcquireFrame(CameraHandle);
%   I = pxcColorImage(CameraHandle); 
%   pxcReleaseFrame(CameraHandle);
%	I=permute(I([3,2,1],:,:),[3 2 1]);
%   figure, imshow(I);
%
% See also pxcOpenCamera, pxcColorImage
%
% Written by D.Kroon Focal 2.0 Oldenzaal (11-7-2013)
