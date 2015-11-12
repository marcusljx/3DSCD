function weights = mls_calculate_weights( P, r, h )
% EVALUATE WEIGHTS OF POINTS IN P TO r USING h-value
[M,N] = size(P);
weights = zeros(M,1);
	for i=1:size(P,1)
		weights(i) = mls_weight( eucDist( P(i,:), r ), h );
	end
end

