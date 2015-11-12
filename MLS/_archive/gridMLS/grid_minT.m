function ss = grid_minT( t, r, weights, data)
	[m,n] = size(data);
	tt = repmat( r+t, m, n );
	wv = weights .* abs( data - tt );
	
	ss = sum(sum(wv));
end

