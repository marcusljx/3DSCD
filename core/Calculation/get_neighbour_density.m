% GET_NEIGHBOUR_DENSITY -- Returns arbitrary map of weighted closest
% neighbours for each point in the input
%
%	INPUT -> Organised Point Cloud P (m x 3)
% OUTPUT-> map of values for each point (m x 4)
function [ P_map ] = get_neighbour_density( P, locus_dist, h )
	[m,~] = size(P);
	P_map = [P, zeros(m,1)];

	%loop through each point
	for i=1:m
		r = P(i,:);
		nn_points = nearestDistNeighbours(P, r, locus_dist);
		NN_weights = mls_calculate_weights(nn_points,r,h);
		P_map(i,4) = sum(NN_weights) / size(NN_weights,1);
	end
end

