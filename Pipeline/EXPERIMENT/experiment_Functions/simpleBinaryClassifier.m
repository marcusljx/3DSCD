function result = simpleBinaryClassifier( filename, pixelThreshold, changeThreshold )
  resultFolder = strcat(pwd,'/Pipeline/EXPERIMENT/result/');
	filepath = strcat(resultFolder, filename);
	load(filepath);
    
    dev1 = abs(ROMIref{2}-ROMIthis{2});
    dev2 = abs(ROMIref{3}-ROMIthis{3});
    
    C1 = sum(sum(dev1>changeThreshold));
    C2 = sum(sum(dev2>changeThreshold));
    
    if(pixelThreshold >=1)
        pT1 = pixelThreshold;
        pT2 = pixelThreshold;
    else
        [M1,N1] = size(ROMIref{2});
        [M2,N2] = size(ROMIref{3});
        pT1 = pixelThreshold * M1*N1;
        pT2 = pixelThreshold * M2*N2;
    end
    
    result = [C1>pT1, C2>pT2];
end

