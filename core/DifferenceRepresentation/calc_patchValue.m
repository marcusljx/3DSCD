function value = calc_patchValue( patch )
	[M,N] = size(patch);
	
	tophalf = patch(1:M/2,:);
	bottomhalf = patch(M/2 : M, :);
	lefthalf = patch(:, 1:N/2);
	righthalf = patch(:, N/2 : N);
	
	value = ( abs( sum(sum(tophalf)) - sum(sum(bottomhalf)) ) ... 
					+ abs( sum(sum(lefthalf)) - sum(sum(righthalf)) ) ...
					)/2;
end

