D1 = ROMIref{2};
D2 = ROMIthis{2};
thresholdPercentile = 0.9;

[M,N] = size(D1);
absDev = absoluteDifference(D1,D2);
minDev = min(min(absDev));
maxDev = max(max(absDev));
meanDev = mean(mean(absDev(~isnan(absDev))));
fullPercentileDev = (2*meanDev) - minDev;		% effectively == minDev + 2*(meanDev - minDev)

thresh = minDev + (thresholdPercentile * (2*meanDev - minDev));
patchsize = 4;

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

devTitle = sprintf('Change Threshold Index (percentile of total change) = %d', thresholdPercentile);

figmain=figure;
subplot(3,2,1), show_depthmap_relative(D1); title('D1');
subplot(3,2,2), show_depthmap_relative(D2); title('D2');
subplot(3,2,[3,4]), show_depthmap_relative(absDev); title('absDev');
subplot(3,2,[5,6]), show_binaryMap(binDev); title(devTitle);