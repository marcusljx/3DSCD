%MLS2P5D_OBJECTIVEFUNC -- objective function used for minimisation
%	inputs:
%		t is a scalar value that is added to r(3) (minimisation goal)
%		P is a [M x 3] set of points (can be non-grid-fixed points)
%		r is a [1 x 3] point where r(1) and r(2) are integers (grid-fixed points)
%		h is the mls gaussian parameter

function objective_sum = mls2p5D_objectiveFunc( t, P, r, h )
	
	% calculate weights
	weight_distances = get_distances_to_point(P,r);
	weights = mls_weight(weight_distances, h);
	
	% newpoint distance
	q = r;
	q(3) = r(3)+t;
	newpoint_distances = get_distances_to_point(P,q);
	
	objective_sum = sum(newpoint_distances .* weights);
end

