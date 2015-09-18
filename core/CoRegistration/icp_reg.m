function new_after = icp_reg( after, before, tol )
	tol = tol * ones(3,1);

	CUTOFF = 0;
	while( CUTOFF == 0 )
		% FIND CORRESPONDENCE
		IDX = knnsearch(before,after);
		C1 = after;
		C2 = before(IDX,:);

		% MATCH BY REGISTRATION
		[R, t] = LS_SVD_findRt(C1, C2);

		% APPLY TRANSFORM
		new_P1 = ( ( R * after' ) + repmat( t, 1, size(after,1)) )';
		after = new_P1;

		% CHECK LIMIT
		diff_R = abs(R - eye(3,3));		%identity means no movement
		diff_t = abs(t); % zero means no movement
		if( ( sum(mean(diff_R) < tol')==3 ) && ( sum(diff_t < tol)==3 ) )
			CUTOFF = 1;
		else
			CUTOFF = 0;
		end
	end
	
	new_after = new_P1;
end

