%MERGEINTOLARGERFRAME Summary of this function goes here
%   Detailed explanation goes here

function [newP1, newFP2, newM, newN] = shiftIntoLargerFrame( P1, FP2 )
	% note that for 2D data the origin is (1,1)
	min_M = floor( min( [P1(:,1);FP2(:,1)] ) );
	max_M = ceil( max( [P1(:,1);FP2(:,1)] ) );
	min_N = floor( min( [P1(:,2);FP2(:,2)] ) );
	max_N = ceil( max( [P1(:,2);FP2(:,2)] ) );

	newP1 = P1;
	newFP2 = FP2;
	
	if(min_M < 1)
		change_M = 1-min_M;
		newM = max_M + change_M;
		newP1(:,1) = newP1(:,1) + change_M;
		newFP2(:,1) = newFP2(:,1) + change_M;
	else
		newM = max_M;
	end
	
	if(min_N < 1)
		change_N = 1-min_N;
		newN = max_N + change_N;
		newP1(:,2) = newP1(:,2) + change_N;
		newFP2(:,2) = newFP2(:,2) + change_N;
	else
		newN = max_N;
	end
	
end

