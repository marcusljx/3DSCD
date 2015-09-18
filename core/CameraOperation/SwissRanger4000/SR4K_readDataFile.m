function [ depthmap, cXmap, cYmap, ampmap, confmap ] = SR4K_readDataFile( filepath )
	cols = 176;
	rows = 144;
	format = [repmat('%f', 1, cols), '%s'];

	% extract depthmap
	fid = fopen(filepath);
	if(fid == -1) 
		error('Filepath not found');
	end
	
	depthmap = textscan(fid, format, rows, 'HeaderLines', 1);
	depthmap = cell2mat(depthmap(1:cols));
	fclose(fid);

	% extract calibrated X-vector map
	fid = fopen(filepath);
	cXmap = textscan(fid, format, rows, 'HeaderLines', (1 + rows)+1);
	cXmap = cell2mat(cXmap(1:cols));
	fclose(fid);

	% extract calibrated Y-vector map
	fid = fopen(filepath);
	cYmap = textscan(fid, format, rows, 'HeaderLines', 2*(1 + rows)+1);
	cYmap = cell2mat(cYmap(1:cols));
	fclose(fid);

	% extract amplitude map
	fid = fopen(filepath);
	ampmap = textscan(fid, format, rows, 'HeaderLines', 3*(1 + rows)+1);
	ampmap = cell2mat(ampmap(1:cols));
	fclose(fid);

	% extract confidence map
	fid = fopen(filepath);
	confmap = textscan(fid, format, rows, 'HeaderLines', 4*(1 + rows)+1);
	confmap = cell2mat(confmap(1:cols));
	fclose(fid);
end

