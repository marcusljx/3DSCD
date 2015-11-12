%MLS_OCCLUDE_INTERPOLATE --- Combination interpolation-mls while invalidating
%															occluded sections
%	INPUTS:
%		point_cloud			Point Cloud data to interpolate
%		x_limit					maximum dimension for x-axis
%		y_limit					maximum dimension for y-axis
%		h								guassian parameter for mls

function result_D = mls_occlude_interpolate( point_cloud, x_limit, y_limit, h )
	result_D = nan(x_limit,y_limit);
	Pd = point_cloud(:,[1,2]);
	invdist = sqrt(0.5);
	%loop through all possible points
	parfor i=1:x_limit
		for j=1:y_limit
			% find locality of position to point in cloud
			r = [i,j];
			idx = rangesearch(r, Pd, invdist);
			is_real = sum( ~cellfun(@isempty, idx) );
			
			%only conduct MLS if point is valid
			if( is_real > 0 )
				% set initial point as nearest point height
				iter = knnsearch(Pd, r);
				r = [r, point_cloud(iter,3)];
				
				% runMLS_2p5D to shift point to correct height
				q = MLS_2p5D_single(point_cloud, r, h);
				
				% put point in result depthmap
				result_D(i,j) = q(3);
			end
		end
% 		fprintf('i=%i complete\n',i);
	end
end

