function combineDev = combinedDifference_abs( D1, D2, thresholdPercentile )
    binDev = regionAvgThresholdDifference(D1,D2, thresholdPercentile);
    absDev = absoluteDifference(D1,D2);

    combineDev = binDev .* absDev;

end

