function dev = dDiff( D1, D2, type )
	switch type
		case 'standard'
			dev = standardDifference(D1, D2);
			
		case 'absolute'
			dev = absoluteDifference(D1, D2);
			
		case 'feature'
			dev = featureDifference(D1, D2);
			
		case 'region'
			dev = regionAvgThresholdDifference(D1, D2, 0.75);
		
	end
end

