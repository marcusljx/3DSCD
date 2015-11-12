%REG_FIND_CORRESPONDENCES
%   Find closest-point correspondences of P2 to points in P1
% 
%		INPUTS:
%			P1, P2 == [M x 3] Organised Point Cloud data (the M-sizes of P1 and P2 may differ)
% 
%		OUTPUTS:
%			corr == [m x 2]	matrix of indices
function [ corr, sorted_p1, sorted_p2 ] = REG_find_correspondences( P1, P2 )
% 	%identify model and source (source must be the smaller)
% 	if (size(P1,1) < size(P2,1))
% 		REFERENCE = P2;
% 		SOURCE = P1;
% 		src_is_p1 = 1;	% boolean marker
% 	else 
% 		REFERENCE = P1;
% 		SOURCE = P2;
% 		src_is_p1 = -1;	% boolean marker
% 	end

	SOURCE = P1;
	REFERENCE = P2;

	[M, N] = size(SOURCE);
	
	sorted_p1 = zeros(M,3);
	sorted_p2 = zeros(M,3);
	corr = zeros(M,1);
	
	
	
% 	
% 	% LOOP TO FIND UNIQUE CORRESPONDENCES (ONE-TO-ONE)
% 	% (find closest point in REF for every point in SRC)
% 	for i = 1:M
% 		[corr(i), ~] = knnsearch(REFERENCE, SOURCE(i,:));
% 		
% 		% assign result
% 		if(src_is_p1 == 1)
% 			sorted_p1(i,:) = SOURCE(i,:);
% 			sorted_p2(i,:) = REFERENCE( corr(i), :);
% 		else
% 			sorted_p1(i,:) = REFERENCE( corr(i), :);
% 			sorted_p2(i,:) = SOURCE(i,:);
% 		end
% 
% 		% remove unique point from reference
% 		REFERENCE(corr(i),:) = -1*ones(1,N);
	end
end

