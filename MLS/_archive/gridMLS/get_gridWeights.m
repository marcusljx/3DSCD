%GET_WEIGHTEDGRIDDISTANCES -- RETURNS GRID OF WEIGHTED DISTANCES FROM POINT (i,j)
%   
function weights = get_gridWeights( G, i,j, h)
	G = cast(G, 'double');
	[m,n] = size(G);

	% vertical distances
	verticals_L = fliplr(0:j-1);
	if(n-j >=0 )
		verticals_R = (1:n-j);
		verticals = repmat( [verticals_L,verticals_R], m, 1 );
	else
		verticals = repmap( verticals_L, m , 1 )';
	end
	ver = verticals .^ 2;
	
	% horizontal distances
	horizontals_U = flipud( (0:i-1)' );
	if(m-i >=0 )
		horizontals_D = (1:m-i)';
		horizontals = repmat( [horizontals_U;horizontals_D], 1, n );
	else
		horizontals = repmat( horizontals_U, 1, n );
	end
	hor = horizontals .^ 2;
	
	% depth distances
	r = G(i,j);
	z = (repmat( r, m, n ) - G) .^ 2;
	distances = sqrt( ver + hor + z );

	% weights
	weights = exp( -(distances .^ 2) ./ h^2 );
end

