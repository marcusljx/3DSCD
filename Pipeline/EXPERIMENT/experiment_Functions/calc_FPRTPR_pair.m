function [FPR, TPR] = calc_FPRTPR_pair( dirstruct, pixelThresh, changeThresh, expected )
    N = size(expected,1);
    output1 = nan(N,1);
    output2 = nan(N,1);
    parfor i=1:N
        filename = dirstruct(i).name; %fprintf('%s\n', filename);
        result = simpleBinaryClassifier(filename, pixelThresh, changeThresh);
        output1(i) = result(1);
        output2(i) = result(2);
    end
    %% count rates
    output = [output1,output2];
    correctOutputs = ~xor(expected,output);
    trueNegatives = correctOutputs(1:N/2);
    truePositives = correctOutputs((N/2)+1:N);
    
    Sensitivity = sum(sum(truePositives))/(N/2);  TPR = Sensitivity;
    Specificity = sum(sum(trueNegatives))/(N/2);  FPR = 1-Specificity;

end

