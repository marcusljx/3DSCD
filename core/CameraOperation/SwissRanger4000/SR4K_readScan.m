function [ multiDepth, multiConf, avgDepth, avgConf ] = SR4K_readScan( filepathPrefix, cropWidth, cropHeight )
	i = 0000;
	multiDepth = nan(144, 176,1);
	multiConf = nan(144,176,1);
	while (true)
		i = i+1;
		filepath = sprintf('%s_%04i.dat', filepathPrefix, i);
		try
			[D, ~, ~, ~, C] = SR4K_readDataFile(filepath);
			multiDepth = cat(3, multiDepth, D);
			multiConf = cat(3, multiConf, C);
		catch
			break
		end
		disp(filepath);
	end
	multiDepth(:,:,1) = [];
	multiConf(:,:,1) = [];
	avgDepth = mean(multiDepth,3);
	avgConf = mean(multiConf,3);
	
	% TRIM EDGE OF FRAME
	multiDepth = cropDepthMap(multiDepth, cropWidth, cropHeight);
	multiConf = cropDepthMap(multiConf, cropWidth, cropHeight);
	avgDepth = cropDepthMap(avgDepth, cropWidth, cropHeight);
	avgConf = cropDepthMap(avgConf, cropWidth, cropHeight);
end

