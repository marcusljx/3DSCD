function ss = cross_minT( t, r, wSet, dSet )
	[~,~,N] = size(dSet);
	
	%create modified combined grid
	ss = 0;
	for i=1:N
		ss = ss + grid_minT(t, r, wSet(:,:,i), dSet(:,:,i));
	end

end

