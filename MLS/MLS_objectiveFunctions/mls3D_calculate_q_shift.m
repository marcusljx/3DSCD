% SHIFTS q OVER A LOCALISED PLANE (X-Y LOCAL COORDS) IN 3D

function q_shift_vector = mls3D_calculate_q_shift(q_shift_vector, H_q, H_projected_points, weights, h )
	upper_bound = h/2;
	lower_bound = -h/2;
	%% X-TARGET SHIFT
	X_q_shift = q_shift_vector(1);
	X_H_q = H_q(1);
	X_H_projected_points = H_projected_points(:,1);
	
	min_X_shift = fminbnd(@(X_q_shift) ...
														mls_calculate_projected_q(X_q_shift,		...
																										X_H_q,			...
																										X_H_projected_points,	...
																										weights) , ...
														lower_bound, upper_bound);
	
% 	% distance & weighted distances
% 	X_distances = get_distances_to_point(X_H_projected_points, X_H_q + X_q_shift);
% 	X_weighted_distances = X_distances .* weights;
% 	% sum
% 	X_sum_of_weighted_distances = sum(X_weighted_distances);
% 	% shift
% 	X_new_q_shift = ( X_sum_of_weighted_distances / sum(weights) );

	
	%% Y-TARGET SHIFT
	Y_q_shift = q_shift_vector(2);
	Y_H_q = H_q(2);
	Y_H_projected_points = H_projected_points(:,2);
	
	min_Y_shift = fminbnd(@(Y_q_shift) ...
														mls_calculate_projected_q(Y_q_shift,		...
																										Y_H_q,			...
																										Y_H_projected_points,	...
																										weights) , ...
														lower_bound, upper_bound);
	
% 	% distance & weighted distances
% 	Y_distances = get_distances_to_point(Y_H_projected_points, Y_H_q + Y_q_shift);
% 	Y_weighted_distances = Y_distances .* weights;
% 	% sum
% 	Y_sum_of_weighted_distances = sum(Y_weighted_distances);
% 	% shift
% 	Y_new_q_shift = ( Y_sum_of_weighted_distances / sum(weights) );
	
	
	%% TOTAL SHIFT
	q_shift_vector = [ min_X_shift; min_Y_shift ];
end

