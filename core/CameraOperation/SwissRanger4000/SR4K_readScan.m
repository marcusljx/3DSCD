function [ DD, XX, YY, AA, CC] = SR4K_readScan( filepathPrefix, cropWidth, cropHeight, combineType )
	i = 0000;
	multiDepth = nan(144, 176,1);
	multiX = nan(144, 176,1);
	multiY = nan(144, 176,1);
	multiAmp = nan(144, 176,1);
	multiConf = nan(144, 176,1);
	while (true)
		i = i+1;
		filepath = sprintf('%s_%04i.dat', filepathPrefix, i);
		try
			[D, X, Y, A, C] = SR4K_readDataFile(filepath);
			multiDepth = cat(3, multiDepth, D);
      multiX = cat(3, multiAmp, X);
      multiY = cat(3, multiAmp, Y);
      multiAmp = cat(3, multiAmp, A);
			multiConf = cat(3, multiConf, C);
		catch
			break
		end
		disp(filepath);
	end
	multiDepth(:,:,1) = [];
	multiX(:,:,1) = [];
	multiY(:,:,1) = [];
	multiAmp(:,:,1) = [];
	multiConf(:,:,1) = [];
	
	% CROP FRAME
	multiDepth = cropDepthMap(multiDepth, cropWidth, cropHeight);
	multiX = cropDepthMap(multiX, cropWidth, cropHeight);
	multiY = cropDepthMap(multiY, cropWidth, cropHeight);
	multiAmp = cropDepthMap(multiAmp, cropWidth, cropHeight);
	multiConf = cropDepthMap(multiConf, cropWidth, cropHeight);
	
	if(strcmp(combineType,'multi'))
		DD = multiDepth;
		XX = multiX;
		YY = multiY;
		AA = multiAmp;
		CC = multiConf;
	else
		DD = mean(multiDepth,3);
		XX = mean(multiX,3);
		YY = mean(multiY,3);
		AA = mean(multiAmp,3);
		CC = mean(multiConf,3);
	end
	
end

