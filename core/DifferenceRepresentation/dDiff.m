function dev = dDiff( D1, D2, type, thresh )
	switch type
		case 'standard'
			dev = standardDifference(D1, D2);
			
		case 'absolute'
			dev = absoluteDifference(D1, D2);
			
		case 'feature'
			dev = featureDifference(D1, D2);
			
		case 'region'
			dev = regionAvgThresholdDifference(D1, D2, thresh);
		
		case 'combined_abs'
			dev = combinedDifference_abs(D1,D2,thresh);

		case 'combined_std'
			dev = combinedDifference_std(D1,D2,thresh);
	end
end

