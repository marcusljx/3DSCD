function [result, avgVal_of_occurence] = old_BinaryClassifier( filename, changeThreshold )
	if(nargin < 2)
		changeThreshold = 1.0;
	end

	resultFolder = strcat(pwd,'/Pipeline/EXPERIMENT/result/');
	filepath = strcat(resultFolder, filename);
	load(filepath);
    
    result = zeros(1,2);
    avgVal_of_occurence = zeros(1,2);
	
	% calculate region-binary and absolute value change maps
	baseThresh = 0.99;
    for i=1:2
        binDev = dDiff(ROMIref{i+1}, ROMIthis{i+1}, 'region', baseThresh);
        dev = dDiff(ROMIref{i+1}, ROMIthis{i+1}, 'combined_abs', baseThresh);
        binDev(isnan(binDev)) = 0;
        dev(dev==0) = nan;

        % get min max and average
%         devMin = min(min(dev));
%         devMax = max(max(dev));
%         gap = devMax - devMin;

        dev(isnan(dev)) = 0;

        [m,n] = size(dev);
        totalArea = m*n;

        % qualifiers
        variance = getVarianceInPatch(binDev, dev);
        area = sum(sum(binDev));
        area_of_occurence = area / totalArea;
        affectance = sum(sum(dev));
        
        avgVal_of_occurence(i) = (affectance/totalArea) + (variance/area);
        
        %postprocessing
        if(isnan(avgVal_of_occurence(i)))
            avgVal_of_occurence(i) = 0;
        end

        if(avgVal_of_occurence(i) > changeThreshold)
            result(i) = true;
        else
            result(i) = false;
        end
    end
end

