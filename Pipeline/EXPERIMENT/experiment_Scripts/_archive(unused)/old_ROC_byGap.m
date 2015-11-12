% modify here
genericType = 'SR4K_Y';

%% no change
resultFolder = strcat(pwd, '/Pipeline/EXPERIMENT/result/');
savePath = strcat(pwd, '/Pipeline/EXPERIMENT/ROCdata/special', genericType, '.mat');
dirstruct = dir(strcat(resultFolder, genericType, '*.mat'));
fprintf('Thresh \t\tFPR \tTPR\n');

%% GLOBALS
N = size(dirstruct,1);
expected = [false(N/2,2);true(N/2,2)];
FPR_TPR = [1,1];

%% Part0: MinThresh = 0
minThresh = 0.0;
[FPR,TPR] = calc_FPRTPR_pair(dirstruct, minThresh, expected);
FPR_TPR = [FPR_TPR; [FPR,TPR]];
fprintf('%.4f \t\t%.4f \t%.4f\n', minThresh, FPR, TPR);

%% Part1: Finding MaxThresh
maxThresh = 0.001;
value_repeat = 1e-4;
old_FPR = FPR;
old_TPR = TPR;
while( (FPR~=0.0) || (TPR~=0.0) )
    [FPR,TPR] = calc_FPRTPR_pair(dirstruct, maxThresh, expected);
    
    % if same value pair doesn't exist, add it in
    if( sum(FPR_TPR(:,1)==FPR) > 0 )
        found = FPR_TPR(FPR_TPR(:,1) == FPR,:);
        if( sum(found(:,2)==TPR) <= 0 )
            FPR_TPR = [FPR_TPR; [FPR,TPR]];
        end
    else
        FPR_TPR = [FPR_TPR; [FPR,TPR]];
    end
    
    % if repeated values, double the step
    if( (FPR == old_FPR) && (TPR == old_TPR) )
        value_repeat = value_repeat *2;
    end
    maxThresh = maxThresh + value_repeat;
    fprintf('%.4f \t\t%.4f \t%.4f\n', maxThresh, FPR, TPR);
    old_FPR = FPR;
    old_TPR = TPR;
end

combineROC;

