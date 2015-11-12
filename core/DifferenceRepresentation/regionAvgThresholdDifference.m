function binDev = regionAvgThresholdDifference( D1, D2, thresholdPercentile )
	[M,N] = size(D1);
	absDev = absoluteDifference(D1,D2);
	minDev = min(min(absDev));
	meanDev = mean(mean(absDev(~isnan(absDev))));
% 	fullPercentileDev = (2*meanDev) - minDev;		% effectively == minDev + 2*(meanDev - minDev)

	thresh = minDev + (thresholdPercentile * (2*(meanDev - minDev)));
	
	%if threshold is too low (no general change), return no change
	if(abs(thresh) < 0.05) 
		binDev = false(M,N);
	else
		patchsize = 8;
		binDev = true(M,N);

		for i=1:M-(patchsize-1)
			for j=1:N-(patchsize-1)
				patch = absDev(i:i+patchsize-1 , j:j+patchsize-1);
				value = mean(patch(~isnan(patch)));

				binDev(i:i+patchsize-1 , j:j+patchsize-1) = (~isnan(patch));		% stay invalidated (nan) points
				if(value >= thresh)
					binDev(i:i+patchsize-1 , j:j+patchsize-1) = binDev(i:i+patchsize-1 , j:j+patchsize-1) & true(patchsize, patchsize);
				else
					binDev(i:i+patchsize-1 , j:j+patchsize-1) = false(patchsize, patchsize);
				end
			end
		end
	end
end

