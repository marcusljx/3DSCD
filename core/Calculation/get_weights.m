function weights = get_weights( Points, target_point, h )
	weights = [];
	
	for i=1:size(Points,1)
		distance_to_r = pdist( [Points(i,:);target_point] );
		weight = mls_weight(distance_to_r,h);
		weights = [weights; weight];
	end
end

