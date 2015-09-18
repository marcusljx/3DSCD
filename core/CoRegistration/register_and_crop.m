function [ CR1, CR2, deviance_map ] = register_and_crop( P1, P2, tol )
	% primary registration
	[ FP1, FP2 ] = icp_reg( P1, P2, tol );

	% find closest registered points CR1 from (FP1 closest to FP2) // bias toward Z-axis
	[IDX, Distances] = knnsearch(FP1(:,1:2), FP2(:,1:2));
	approp_dist = mean(Distances);
	new_idx = [IDX, Distances];
	new_idx = new_idx(new_idx(:,2)<approp_dist, 1);
	CR1 = FP1(new_idx, :);
	
	% find closest registered points CR2 from (FP2 closest to CR1) // bias toward Z-a
	[IDX, Distances] = knnsearch(FP2(:,1:2), CR1(:,1:2));
	new_idx = [IDX, Distances];
	new_idx = new_idx(new_idx(:,2)<approp_dist, 1);
	CR2 = FP2(new_idx, :);
	
	% form deviance map
	[C2_IDX, CC_Distances] = knnsearch(CR1, CR2);
	
	deviance_map = [CR2(:,1:2), CC_Distances];
end

