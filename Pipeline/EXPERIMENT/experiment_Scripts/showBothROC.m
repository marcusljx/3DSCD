clear
clc

load( strcat(pwd, '/Pipeline/EXPERIMENT/ROCdata/SR4K.mat') );
SR4K_FPR_TPR = FPR_TPR;

load( strcat(pwd, '/Pipeline/EXPERIMENT/ROCdata/SENZ3D.mat') );
SENZ3D_FPR_TPR = FPR_TPR;

plot(   SENZ3D_FPR_TPR(:,1), SENZ3D_FPR_TPR(:,2), ...
        SR4K_FPR_TPR(:,1), SR4K_FPR_TPR(:,2), ...
        'LineWidth', 2);
title('ROC');
legend('SENZ3D', 'SR4K');
xaxisname = sprintf('False-Positive Rate (FPR)\n1 - Specificity');
yaxisname = sprintf('True-Positive Rate (TPR)\nSensitivity');
xlabel(xaxisname);
ylabel(yaxisname);