function viewAllResultsOnThresh( type, thresh )
	exp = {'_N_0', '_N_S', '_N_D', '_N_1', '_N_2', '_N_3', '_N_4', '_N_5', '_N_SH', '_N_SV'};

	for i=1:size(exp,2)
		filename = strcat(type, exp{i});
		experiment_resultViewer(filename, thresh);
	end

end

