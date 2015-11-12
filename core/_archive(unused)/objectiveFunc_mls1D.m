%MLS1D Summary of this function goes here
%   P : a vector of scallar values
%		r : a single scalar value
function objective = objectiveFunc_mls1D( t, P, r, h )
	d = abs(P - r);
	weights = mls_weight(d,h);
	S = abs( P - (r+t) );
	
	objective = sum( S .* weights );
end

