% This function pxcDepthImage can be used to obtain the Depth-image from 
% the Senz3D camera.      
%
% [D,C,UV] = pxcDepthImage(CameraHandle);
%
% inputs,
%   CameraHandle : Camera Handle to Senz3D camera
%   
% Ouputs,
%   D : depth map (UInt16), note the dimension are [Y,X] thus rotated 
%   C : confidence map (Uint16)
%   UV : uvmap.
%
%   The resolution of the UV map is the same as the depth map. 
%   Each UV map pixel contains two floating point numbers, or
%   normalized coordinates (0-1), in the color picture resolution.
%   float *uvmap=(float*)ddata.planes[2];
%   int index=((int)y)*depthInfo->width+x;
%   x=uvmap[index*2]*colorInfo->width;
%   y=uvmap[index*2+1]*colorInfo->height;
%   Alternatively, some cameras provide the PXCProjection interface for explicit conversion among
%   2D depth coordinates, 2D color coordinates, and 3D real world coordinates.
%
%
% Example,
% 	CameraHandle  = pxcOpenCamera();
%   pxcAcquireFrame(CameraHandle);
% 	D = pxcDepthImage(CameraHandle); 
%   pxcReleaseFrame(CameraHandle);
%	D = permute(D,[2 1]);
%   figure, imshow(D,[250 750]);
%
% See also pxcOpenCamera, pxcColorImage
%
% Written by D.Kroon Focal 2.0 Oldenzaal (11-7-2013)
