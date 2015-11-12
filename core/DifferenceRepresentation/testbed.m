D1 = ROMIref{2};
D2 = ROMIthis{2};
thresholdPercentile = 0.9;

    binDev = regionAvgThresholdDifference(D1,D2, thresholdPercentile);
    stdDev = standardDifference(D1,D2);

    combineDev = binDev .* stdDev;

devTitle = sprintf('Combined Standard Diff. with Threshold = %d', thresholdPercentile);

figmain=figure;
subplot(3,2,1), show_depthmap_relative(D1); title('D1');
subplot(3,2,2), show_depthmap_relative(D2); title('D2');
subplot(3,2,[3,4]), show_depthmap_relative(stdDev); title('absDev');
subplot(3,2,5), show_binaryMap(binDev); title('binDev');

subplot(3,2,6), show_depthmap_relative(combineDev); title(devTitle);