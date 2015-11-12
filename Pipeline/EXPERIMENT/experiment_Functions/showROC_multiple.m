function fig_main = showROC_multiple( files, names, Title )
    ROC_folder = strcat(pwd, '\Pipeline\EXPERIMENT\ROCdata\');
    fig_main = figure;
    
    if(size(files) ~= size(names))
        error('input cell-array sizes do not match');
    end
    
    for i=1:size(files,2)
       load( strcat( ROC_folder, files{i} ) );
       plot(FPR_TPR(:,1), FPR_TPR(:,2), 'LineWidth',2);
       hold on;
    end
    title(Title);
    legend(names);
		
		xaxisname = sprintf('False-Positive Rate (FPR)\n1 - Specificity');
		yaxisname = sprintf('True-Positive Rate (TPR)\nSensitivity');
		xlabel(xaxisname);
		ylabel(yaxisname);
end

