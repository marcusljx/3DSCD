function normal = mls_initial_normal_estimation( P, r, h )
%MLS_NORMAL_ESTIMATION
%   uses weighted-covariance matrix derived from P to obtain a normal
%		weight is dependent on euc.distance of r to each point in P
%		calls:
% 				weighted_cov.m
				
% FIND WEIGHTED-COVARIANCE MATRIX B
	B = weighted_cov(P, r, h);

% FIND EIGENVECTORS AND EIGENVALUES OF B
	[V, eigVals] = eig(B);
	V = real(V);							% extract only real component
	eigVals = real(eigVals);	% extract only real component

% NORMAL = EIGENVECTOR CORRESPONDING TO MINIMUM EIGENVALUE IN B
	[ ev, pos] = min( diag(eigVals) );
	normal = V(:,pos);
	normal = normal ./ norm( normal );					% normalize if not already
end

