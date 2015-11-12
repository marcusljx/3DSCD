clear
clc

genericType = 'SR4K';
minThresh = 0.0;
maxThresh = 3.0;
step = 0.01;

resultFolder = strcat(pwd,'/Pipeline/EXPERIMENT/result/');
rocFolder = strcat(pwd,'/Pipeline/EXPERIMENT/ROCdata/');
dirstruct = dir(strcat(resultFolder,'/',genericType,'*.mat'));
savePath = strcat(rocFolder, genericType, '.mat');

%% GLOBALS
N = size(dirstruct,1);

expected = [false(N/2,2);true(N/2,2)];
output1 = false(N,1);
output2 = false(N,1);
singleLineOutput = false(1,N);
FPR_TPR = zeros(size(minThresh:step:maxThresh,2),2);


%% loop over thresholds
fprintf('Thresh \t\tFPR \tTPR\n');
rocPt = 1;
for thresh = minThresh: step : maxThresh
    parfor i=1:N
        filename = dirstruct(i).name; %fprintf('%s\n', filename);
        [result,~] = BinaryClassifier(filename, thresh);
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
    
    FPR_TPR(rocPt,1) = FPR;
    FPR_TPR(rocPt,2) = TPR;
    rocPt = rocPt + 1;
    fprintf('%.4f \t\t%.4f \t%.4f\n', thresh, FPR, TPR);
end
rocPlot = plot(FPR_TPR(:,1),FPR_TPR(:,2));
save(savePath, 'FPR_TPR', 'rocPlot');