function combineDev = combinedDifference_std( D1, D2, thresholdPercentile )
    binDev = regionAvgThresholdDifference(D1,D2, thresholdPercentile);
    stdDev = standardDifference(D1,D2);

    combineDev = binDev .* stdDev;
end

