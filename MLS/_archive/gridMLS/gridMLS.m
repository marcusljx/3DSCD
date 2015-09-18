%GRIDMLS -- Performs MLS projection on all points in an array
% INPUT: 
% 	G	= {m x n} array of data points
%		h			= {scalar} Gaussian parameter
% 
% OUTPUT: 
%		mlsG	= {m x n} array of projected points
function mlsG = gridMLS( G, h )
	G = cast(G, 'double');
	[m,n] = size(G);
	mlsG = zeros(m,n);
	
	for i = 1:m
		parfor j = 1:n
			r = G(i,j);
			weights = get_gridWeights(G, i,j, h);
			
			%perform minimisation
			t = 0;
			min_t = fminbnd( @(t) grid_minT(t,r,weights,G), ...
								-h/2, h/2);
			
			mlsG(i,j) = r + min_t;
		end
	end
end

