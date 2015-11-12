clear
clc

pThresh = 0.99;

%no change
Types = {'SR4K_nonopt_Y'};
for t=1:size(Types,2)
    genericType = Types{t};
    cThreshStep = 1e-3;

    resultFolder = strcat(pwd,'/Pipeline/EXPERIMENT/result/');
    rocFolder = strcat(pwd,'/Pipeline/EXPERIMENT/ROCdata/');
    dirstruct = dir(strcat(resultFolder,'/',genericType,'*.mat'));
    savePath = strcat(rocFolder, genericType,'_', sprintf('%.2f',pThresh) ,'p.mat');

    %% GLOBALS
    N = size(dirstruct,1);
    expected = [false(N/2,2);true(N/2,2)];
    cThresh = 0.0;
    originalcThreshStep = cThreshStep;

    %% INITIAL CASE
    [FPR,TPR] = calc_FPRTPR_pair(dirstruct, pThresh, cThresh, expected);
    FPR_TPR = [FPR,TPR];
    cThresh = cThresh + cThreshStep;

    %% loop over thresholds
    fprintf('Thresh \t\tFPR \tTPR\n');
    rep = 1;
    while(~ismember([0,0],FPR_TPR, 'rows'))
        [FPR,TPR] = calc_FPRTPR_pair(dirstruct, pThresh, cThresh, expected);
        fprintf('%.4f \t\t%.4f \t%.4f\n', cThresh, FPR, TPR);

        if(~ismember([FPR,TPR], FPR_TPR, 'rows'))
            if(ismember(FPR, FPR_TPR(:,1)) || ismember(TPR, FPR_TPR(:,2)))
                FPR_TPR = unique([FPR_TPR; [FPR,TPR]], 'rows');
                rep = 1;
            end
            cThresh = cThresh - cThreshStep;    % step backwards, reset stepsize
            cThreshStep = originalcThreshStep * 0.1^rep;
            rep = rep + 1;
        else
            cThreshStep = cThreshStep * 2;
            cThresh = cThresh + cThreshStep;
        end
    end
    %rocPlot = plot(FPR_TPR(:,1),FPR_TPR(:,2));
    save(savePath, 'FPR_TPR');
    Tnames{t} = strcat(Types{t}, sprintf('_%.2fp',pThresh), '.mat');
end