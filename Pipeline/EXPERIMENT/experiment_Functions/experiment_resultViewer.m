function fig = experiment_resultViewer( result_file , thresh)
	resultFolder = strcat(pwd,'\Pipeline\EXPERIMENT\result\');
	filepath = strcat(resultFolder, result_file);
	load(filepath);
	
	isSENZ3D = size(strfind(result_file, 'SENZ3D'),1);
    SFs{1} = SURF{1};
    SFs{2} = SURF{2};
    SFs{3} = SURF{3};
	fig = experiment_viewRDS( isSENZ3D, IMGs, REFs, ROMIref, ROMIthis, SFs, names, 'combined_std', 'relative', thresh);
	set(gcf,'name',strcat(result_file,'__',num2str(thresh)),'numbertitle','off')
end