function distances = get_distances_to_point( points, x )
	% points:: MxN matrix :: M rows of of N-dimensional points.
	% x			:: 1xN point	:: an N-dimensional point

	%returns distances :: Mx1 matrix of euclidean distances to point
% 	distances = [];
	[M,~] = size(points);

	diff = points - repmat(x,M,1);
	sq_diffs = diff.^2;
	S = sum(sq_diffs,2);
	distances = sqrt(S);
	
	
% 	for i = 1:size(points,1)
% 		dist = pdist([points(i,:) ; x]);
% 		distances = [distances;dist];
% 	end
end

