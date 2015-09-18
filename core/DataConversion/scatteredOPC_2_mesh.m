%CONVERTS A SCATTERED (MISSING POINTS) ORGANISED POINT CLOUD BACK TO MESH
function [xq, yq, vq] = scatteredOPC_2_mesh( OPC, gridspacing, sizeX, sizeY )
	OPC = cast(OPC, 'double');	%convert to double (required)
	x = OPC(:,1);
	y = OPC(:,2);
	z = OPC(:,3);
% 
% 		xlin = linspace(min(x),max(x),320/gridstep);
% 		ylin = linspace(min(y),max(y),240/gridstep);
% 		[X,Y] = meshgrid(xlin,ylin);
% 
% 		f = scatteredInterpolant(x,y,z);
% 		Z = f(X,Y);

	x_space = 1:gridspacing:sizeX;
	y_space = 1:gridspacing:sizeY;
	[xq, yq] = meshgrid( x_space, y_space );
	
	vq = griddata(x,y,z, xq,yq, 'natural');

end

