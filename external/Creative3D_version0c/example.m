addpath('Mex')

% Open Device
CameraHandle  = pxcOpenCamera();

if(CameraHandle ==0)
    error('no valid camera handle');
end

h = figure; title('Close this window to stop camera');
% Acquire a Camera Frame, and lock
pxcAcquireFrame(CameraHandle);
D = pxcDepthImage(CameraHandle); D=permute(D,[2 1]);
I = pxcColorImage(CameraHandle); I=permute(I([3,2,1],:,:),[3 2 1]);
% Release the camera frame
pxcReleaseFrame(CameraHandle);

subplot(1,2,1),h1=imshow(I); 
subplot(1,2,2),h2=imshow(D,[200 750]); colormap('jet');
  
while(ishandle(h));
    % Acquire a Camera Frame, and lock
    pxcAcquireFrame(CameraHandle);

    D = pxcDepthImage(CameraHandle); D=permute(D,[2 1]);
    I = pxcColorImage(CameraHandle); I=permute(I([3,2,1],:,:),[3 2 1]);
    
	% Release the camera frame
    pxcReleaseFrame(CameraHandle);

    set(h1,'CDATA',I);
    set(h2,'CDATA',D);
    drawnow; 
end

% Close the Camera
pxcCloseCamera(CameraHandle);