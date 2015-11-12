function B = weighted_cov( P, r, h )
%COV_B creates weighted-covariance matrix B from points p in P[], and r
%	note: P also includes r
%	calls:
% 			mls_weight.m
% 			eucDist.m

	% get dimensions
	[M N] = size(P);

	% get weights ( M x 1 vector )
	weights = mls_calculate_weights(P, r, h);
	
	% remove mean of points
	mean = repmat(weights' * P, M, 1);
	temp = P - mean;
	
	% Create weighted covariance matrix
	B = temp' * ( temp .* repmat(weights, 1, N) );
	%might want to check if covariance matrix is properly symmetric matrix
end

