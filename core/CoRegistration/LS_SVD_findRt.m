function [ ROTATION, TRANSLATION ] = LS_SVD_findRt( P1, P2, weights )
	% if weights not defined
	if (nargin == 2)
		weights = ones( size(P1,1) , 1 );
	end

	[M, N] = size(P1);
	
	%COMPUTE WEIGHTED CENTROIDS
	centroid_P1 = (P1' * weights) ./ sum(weights);
	centroid_P2 = (P2' * weights) ./ sum(weights);

	%COMPUTE CENTERED VECTORS
	xi = P1 - repmat(centroid_P1', M,1);
	yi = P2 - repmat(centroid_P2', M,1);

	%COMPUTE [d x d] COVARIANCE AMTRIX
	X = xi';
	Y = yi';
	W = diag(weights);

	S = Y * W * X';

	%PERFORM SVD
	[U, ~, V] = svd(S);

	%COMPUTE THE ROTATION
	d = size(U,2);
	temp = diag(ones(size(U,2),1));
	temp(d,d) = det(V*U');

% 	actual_rotation
	ROTATION = U * temp * V';
% 	det_R = det(ROTATION);

	%COMPUTE THE TRANSLATION
% 	actual_translation
	TRANSLATION = centroid_P2 - ( ROTATION * centroid_P1);

	%endloop
% 	new_P1 = ((ROTATION * P1') + repmat(TRANSLATION,1,M))';
% 	showPointCloud(P1, 'r'); hold on;
% 	P1 = new_P1;
end

