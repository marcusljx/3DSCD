function new_q_dist = mls_calculate_projected_q(q_dist, projected_q, H_projections, weights )
%MLS_CALCULATE_Q 
% 	Calculates a new q based on the weighted pairs

% DISTANCES TO q
	distances = get_distances_to_point( H_projections, projected_q + q_dist );
	
%	WEIGHTED DISTANCES TO q
	weighted_distances = distances .* weights;
	
% GET SUM
	sum_of_weighted_distances = sum(weighted_distances);
	sum_of_weights = sum(weights);
	
	new_q_dist = (sum_of_weighted_distances / sum_of_weights);
end

