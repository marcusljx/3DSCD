function handle = show_subplotROC( file, generics, name )
	ROC_folder = strcat(pwd, '\Pipeline\EXPERIMENT\ROCdata\');
	
	for i=1:2
		load( strcat( ROC_folder, file{i} ) );
				 handle = plot(FPR_TPR(:,1), FPR_TPR(:,2), 'LineWidth',2);
				 hold on;
		L{i} = sprintf('%s %s', generics{i},name);
	end
	legend({'With Optimal Registration (6DOF + ICP)', 'Without Optimal Registration (ICP only)'});
	
	xaxisname = sprintf('False-Positive Rate (FPR)\n1 - Specificity');
	yaxisname = sprintf('True-Positive Rate (TPR)\nSensitivity');
	xlabel(xaxisname);
	ylabel(yaxisname);
end

