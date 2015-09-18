function mD = mls_multiframeCapture( DD, h )
	disp('doing mls1D on input scans'); tic
	
	[M,N,~] = size(DD);
	
	for i = 1:M
		parfor j = 1:N;
			P = squeeze(DD(i,j,:));
			r = mean(P);
			t = 0;	%initial t

			t = fminbnd(@(t) objectiveFunc_mls1D(t, P, r, h),	...
										(-h/2), (h/2) );

			mD(i,j) = r+t;
		end
		fprintf('i=%i complete.\n', i);
	end
	disp('mls1D complete'); toc

	toc
end

