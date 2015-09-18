function OPC = getOPC_fromFile( filename )
	fileID = fopen(filename,'r')
	formatSpec = '%f %f %f\n';

	size = [3, inf];
	OPC = fscanf(fileID,formatSpec, size)';
	fclose(fileID);
end

