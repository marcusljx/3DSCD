% RE-ESTIMATION OF t GIVEN VALUES
function new_t = mls_calculate_t( old_t,								...
																	r,										...
																	normal,								...
																	number_of_neighbours, ...
																	P,										...
																	weights								...
																	)
% DETERMINE q
	q = (r + old_t*normal')';
	
% FORM REPEATED MATRIX OF q
	rep_q = repmat(q,1, number_of_neighbours)';
	
% MATRIX OF SQUARED DISTANCES TO THE PLANE FORMED BY q
	distances_2_plane = (rep_q - P) * normal;
	distances_2_plane_squared = distances_2_plane .^ 2;
	
% OBTAIN NEW VALUE OF q FROM (SUM-OF-WEIGHTED-SQ_DISTS / SUM-OF-WEIGHTS)
	sum_of_weighted_sq_dist = sum( weights .* distances_2_plane_squared );
	sum_of_weights = sum(weights);
	
	new_t = sum_of_weighted_sq_dist / sum_of_weights;
end

