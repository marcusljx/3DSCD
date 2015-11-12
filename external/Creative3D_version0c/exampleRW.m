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

subplot(1,3,1),h1=imshow(I); 

jmap=jet(256);
subplot(1,3,2),h2=imshow(ind2rgb(uint8(D/3-100),jmap) );
  
hs=[];
while(ishandle(h));
    % Acquire a Camera Frame, and lock
    pxcAcquireFrame(CameraHandle);

    [D,~,UV] = pxcDepthImage(CameraHandle); 
    % Get World coordinates
    XYZ = pxcDepthImage2World(CameraHandle,D);
    
    % Get Image
    I = pxcColorImage(CameraHandle);
    
    % To Matlab data convention
    D  = permute(D,[2 1]);
    UV = permute(UV,[3 2 1]);
    I  = permute(I([3,2,1],:,:),[3 2 1]);
    XYZ = permute(XYZ,[3 2 1]);

    % World coordinates from meter to milimeters.
    XYZ = XYZ*1000;
    
    % Map the depth world coordinates to the color image;
    XYZ = WorldCoordinates2ColorImage(XYZ, UV,size(I));
   
    
    % Limit XYZ
    X = XYZ(:,:,1); Y = XYZ(:,:,2); Z = XYZ(:,:,3);
    Z(Z<200)=200; Z(Z>1000)=1000;
    Z((X<-500)|(X>500)|(Y<-500)|(Y>500))=nan;
    X(X<-500)=-500; X(X>500)= 500;
    Y(Y<-500)=-500; Y(Y>500)= 500;
    
    % Display XYZ
    [ind,map] = rgb2ind(I,255);
    subplot(1,3,3)
    if(ishandle(hs)), 
        set(hs,'XData',X); set(hs,'YData',Y); set(hs,'ZData',750-Z);
        set(hs,'CData',double(ind)/256);
    else
        hs=surf(X,Y,1000-Z,double(ind)/256,'EdgeColor','None'); 
    end
    colormap(map);
    axis ij
    axis equal
    axis vis3d
    view(-28,49)
       
	% Release the camera frame
    pxcReleaseFrame(CameraHandle);

    set(h1,'CDATA',I);
    set(h2,'CDATA',ind2rgb(uint8(D/3-100),jmap));
    drawnow; 
end

% Close the Camera
pxcCloseCamera(CameraHandle);