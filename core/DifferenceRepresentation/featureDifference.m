function dev = featureDifference( D1, D2 )
	[M,N] = size(D1);
	pD1 = zeros(M,N);
	pD2 = zeros(M,N);
	dev = zeros(M,N);
	patchsize = 10;

	patchings_made = zeros(M,N);

	for i=1:M-(patchsize-1)
		for j=1:N-(patchsize-1)
			patch1 = D1(i:i+patchsize-1 , j:j+patchsize-1);
			patch2 = D2(i:i+patchsize-1 , j:j+patchsize-1);

			value1 = calc_patchValue(patch1);
			value2 = calc_patchValue(patch2);

			pD1(i:i+patchsize-1 , j:j+patchsize-1) = pD1(i:i+patchsize-1 , j:j+patchsize-1) + value1;
			pD2(i:i+patchsize-1 , j:j+patchsize-1) = pD2(i:i+patchsize-1 , j:j+patchsize-1) + value2;
			patchings_made(i:i+patchsize-1 , j:j+patchsize-1) = patchings_made(i:i+patchsize-1 , j:j+patchsize-1) + 1;
			dev(i:i+patchsize-1 , j:j+patchsize-1) = dev(i:i+patchsize-1 , j:j+patchsize-1) + abs(value1-value2);
		end
	end

	pD1 = pD1 ./ patchings_made;
	pD2 = pD2 ./ patchings_made;

	dev = dev ./ patchings_made;

end

