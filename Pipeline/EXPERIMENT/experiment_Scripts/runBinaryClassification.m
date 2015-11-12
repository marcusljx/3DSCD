clear
clc
resultFolder = strcat(pwd,'/Pipeline/EXPERIMENT/result/');
dirstruct = dir(strcat(resultFolder,'/SR4K*.mat'));
fprintf('RESULT1 RESULT2 \tavgVal1 \tavgVal2 \t\tFILE\n');

SR4K_N_changeThresh = 5e-3;
SR4K_Y_changeThresh = 20.0;
SENZ3D_N_changeThresh = 0.25;
SENZ3D_Y_changeThresh = 1.0;

for i=1:size(dirstruct,1)
	filename = dirstruct(i).name;
    isSenz3d = size(strfind(filename,'SENZ3D'),2);
    isMoved = size(strfind(filename,'_Y_'),2);
    
    % use different thresholds for all 4 situations
    if(isSenz3d && ~isMoved)
        [result, value] = BinaryClassifier(filename,SENZ3D_N_changeThresh);
    elseif (isSenz3d && isMoved)
        [result, value] = BinaryClassifier(filename,SENZ3D_Y_changeThresh);
    elseif (~isSenz3d && ~isMoved)
        [result, value] = BinaryClassifier(filename,SR4K_N_changeThresh);
    else
        [result, value] = BinaryClassifier(filename,SR4K_Y_changeThresh);
    end
	fprintf('%i \t%i \t\t%.6f \t%.6f \t%s\n', result(1), result(2), value(1), value(2), filename);
end