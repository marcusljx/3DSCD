%%NA_D2OPC Converts DEPTH DATA to ORGANIZED POINT CLOUD matrix
%   input::		DEPTH DATA MATRIX [m x n] of Depth Values in Grid form
% 	output::	oPC MATRIX [M x 3] of rows depicting [x y z] based on inputs
%			differs from depth2OrganizedPointCloud by not performing z-inversion
%%
function oPC = NA_d2OPC( Depth_data )
	[m, n] = size(Depth_data);
	
	X_points = reshape( repmat( [1:m], n, 1), m*n, 1);
	Y_points = repmat([1:n]', m,1);
	Z_points = reshape( Depth_data', m*n, 1);
		
	oPC = [X_points, Y_points, Z_points];
	
	% filter out "beyond range" points from Senz3D (32001 == out of range)
	oPC = oPC( (oPC(:,3) < 32000), :);
	
	% invert points Y-values
	oPC(:,1) = m - oPC(:,1) + 1;
	
	% invert points Y-values
	oPC(:,2) = n - oPC(:,2) + 1;
end

