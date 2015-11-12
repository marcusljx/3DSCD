%% returns matrix of points in set P that are within distance d to point r.
function neighbours = nearestDistNeighbours( P, r, d )
	[idx, ~] = rangesearch(P,r,d);
	idx = idx{1}; %retarded matlab conventions, no uniformity.
	
	neighbours = P(idx,:);
end

