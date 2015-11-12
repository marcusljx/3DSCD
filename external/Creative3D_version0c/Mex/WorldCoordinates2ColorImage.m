function XYZ = WorldCoordinates2ColorImage(XYZ, UV,sizeI)

% Transform Mapping Depthmap to Color from range 0...1 to image-size
% range
UVx=UV(:,:,2)*sizeI(1)+1;
UVy=UV(:,:,1)*sizeI(2)+1;

% XYZ to X,Y,Z
X = XYZ(:,:,1);
Y = XYZ(:,:,2);
Z = XYZ(:,:,3);

% Remove depth points which not inside the color image
ind = (UVx<1)|(UVy<1)|(UVx>sizeI(1))|(UVy>sizeI(2)|(Z>5000));
UVx(ind)=[];
UVy(ind)=[];

% Remove these point also from the world coordinates
X(ind)=[];
Y(ind)=[];
Z(ind)=[];

% Map the world Coordinates to the color image
[xq,yq] = meshgrid(1:sizeI(2),1:sizeI(1));
F = TriScatteredInterp(double(UVy(:)),double(UVx(:)),double(X(:)));
X = F(xq,yq);
F.V = double(Y(:));
Y = F(xq,yq);
F.V = double(Z(:));
Z = F(xq,yq);

% World Coordinates at color image
XYZ = reshape([X Y Z],[sizeI(1) sizeI(2) 3]);