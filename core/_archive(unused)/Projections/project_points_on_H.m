% PROJECT_POINTS_ON_H 
% 		RETURNS SET OF 2D POINTS PROJECTED ON H FORMED BY
%			q AND normal


function [H_q, projected_2D_points, projected_weights] = project_points_on_H( q, normal, set_of_3D_points, h)
	H = null(normal');
	H_q = q' * null(normal');
	projected_2D_points = set_of_3D_points * null(normal');
	
	projected_weights = get_weights(projected_2D_points, H_q, h);
end

