function saveOPC_toFile( var , type)
	current_date = datetime();
	filename = datestr(current_date,'yyyyMMdd_HHmmSS_');
	filename = strcat(filename,type,'.txt');
% 	fprintf('filename=%s\n',filename);
	
	fileID = fopen(filename,'w');
	
	fprintf(fileID, '%7.4f %9.4f %10.4f\n',var');
	
 	fclose(fileID);
end

