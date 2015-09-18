%%DEPTH2POINTCLOUD Converts DEPTH DATA to ORGANIZED POINT CLOUD matrix
%   input::		DEPTH DATA MATRIX [m x n] of Depth Values in Grid form
% 	output::	oPC MATRIX [M x 3] of rows depicting [x y z] based on inputs
%%
function oPC = depth2OrganizedPointCloud( Depth_data )
	[m, n] = size(Depth_data);
	
	X_points = flipud(reshape( repmat( [1:m], n, 1), m*n, 1));
	Y_points = flipud(repmat([1:n]', m,1));
	Z_points = reshape( Depth_data', m*n, 1);
		
	oPC = [X_points, Y_points, Z_points];
	
	% filter out "beyond range" points from Senz3D (32001 == out of range)
	oPC = oPC( (oPC(:,3) < 32000), :);
	
	% invert points Y-values
	oPC(:,1) = m - oPC(:,1) + 1;
	
	% invert points Y-values
	oPC(:,2) = n - oPC(:,2) + 1;
	
	% invert points Z-values
% 	zz = max(oPC(:,3));
% 	oPC(:,3) = zz - oPC(:,3);
end

