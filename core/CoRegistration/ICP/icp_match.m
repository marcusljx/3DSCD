function [ matchSet minDist ] = icp_match( q, p )
	M = size(p,2);
	N = size(q,2);
	matchSet = zeros(1,M);
	minDist = zeros(1,M);

	for ki=1:M
		d = zeros(1,N);
		for ti=1:3
			d = d		...
					+ ( q(ti,:) - p(ti,ki) ).^2;
		end
		
		[minDist(ki), matchSet(ki)] = min(d);
	end
	minDist = sqrt(minDist);
end

