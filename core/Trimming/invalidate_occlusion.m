% INVALIDATE_OCCLUSION
% -- Compares a derived depthmap D to P, where P is the original dataset
% -- Removes points in D that are not "real" (not within 1 unit of any
%			location in P)
% INPUT:
%		D -- depthmap depicting an interpolated dataset of P
%		cloud_P -- PointCloud depicting original dataset with invalid regions

function new_D = invalidate_occlusion( D, cloud_P, invalue )
	[M,N] = size(D);
	
	%	obtain locations of D
	X_points = reshape( repmat( [1:M], N, 1), M*N, 1);
	Y_points = repmat([1:N]', M,1);
	Z_points = reshape( D', M*N, 1);
	opc_D = [X_points,Y_points,Z_points];
	D_loc = [opc_D(:,1), opc_D(:,2)];
	
	% obtain locations of P
	P_loc = cloud_P(:, 1:2);
	
	% find invalid data
	idx = rangesearch(P_loc, D_loc, invalue);
% 	size(idx)
	
	new_Z_points = opc_D(:,3);
% 	size(new_Z_points)
	
	mty = cellfun(@isempty, idx);
	new_Z_points(mty) = nan;
	
	newOPC = opc_D;
	newOPC(:,3) = new_Z_points;
	
	new_D = OPC2_DepthMap(newOPC,M,N);
end

