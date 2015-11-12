%RUNMLS_2P5D --- 2.5D version of MLS, where point is shifted only along
%									z-axis
%	INPUTS:
%		P		---->	[M x 3] Organised Point Cloud
%		r		---->	[1 x 3] point to move
%		h		---->	[scalar] Gaussian Parameter
% 
% OUTPUTS:
%		q	-->	[1 x 3] new position of point
function q = MLS_2p5D_single( P, r, h )
	range = 2*h;
	kernIter = rangesearch(P,r,range);
	kernNeighbours = P(kernIter{1},:);
	
	t = fminbnd( @(t) mls2p5D_objectiveFunc(t, kernNeighbours,r,h), ...
								(-h/2), (h/2) );

	q = r;
	q(3) = r(3) + t;
end

