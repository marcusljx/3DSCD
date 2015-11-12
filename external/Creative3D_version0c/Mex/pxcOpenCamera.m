% This function pxcOpenCamera, opens the video-streams of the 
% Creative Senz3D using the Intel Interactive Gesture SDK
%
% CameraHandle = pxcOpenCamera(rgbSize,depthSize)
%
% Outputs,
%   CameraHandle : Int64 Pointer to the Camera streams 
%
% Inputs,
%   (optional)
%       rgbSize : Size of the RGB-video stream [w,h]
%       depthSize : Size of the Depth-video stream [w,h]
%
% Example,
%   CameraHandle  = pxcOpenCamera([1280,720]);
%
% See also pxcDepthImage, pxcColorImage
%
% Written by D.Kroon Focal 2.0 Oldenzaal (11-7-2013)