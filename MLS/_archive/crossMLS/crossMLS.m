%CROSSMLS -- Performs MLS projection of each average point on all points in an array
% INPUT: 
% 	G	= {m x n} x N array of data points
%		h			= {scalar} Gaussian parameter
% 
% OUTPUT: 
%		mls_CG	= {m x n} array of projected points
function mls_CG = crossMLS( Depth_map_set, h )
	[m,n,N] = size(Depth_map_set);
	
	avg_G = sum(Depth_map_set,3) ./ N;
	mls_CG = zeros(m,n);
	
	for i=1:m
		parfor j=1:n
			r = avg_G(i,j);
			
			% find weight_set
			weight_set = repmat(zeros(m,n), 1,1,N);
			for p=1:N
				wG = Depth_map_set(:,:,p);
				wG(i,j) = r;
				
				w = get_gridWeights(wG, i,j, h);
				weight_set(:,:,p) = w;
			end
			% create mod_dSet
			mod_dSet = Depth_map_set;
			mod_dSet(i,j,:) = r;
			
			% perform cross minimisation
			t = 0;
			min_t = fminbnd( @(t) cross_minT(t,r,weight_set,mod_dSet), ...
								-h/2, h/2);
							
			mls_CG(i,j) = r + min_t;
		end
	end
end

