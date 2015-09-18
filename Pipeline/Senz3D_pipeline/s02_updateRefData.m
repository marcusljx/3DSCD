function s02_updateRefData( refFilePath, ref_grid, this_grid, this_I )
%S02_UPDATEREFDATA Summary of this function goes here
%   Detailed explanation goes here
	ref_grid_surface = this_grid;
	latest_I = this_I;
	
	%% Overwrite missing points in latest_grid with points from old_grid
	[row, col] = find(isnan(ref_grid_surface));
	for i = 1:size(row,1)
		ref_grid_surface(row(i),col(i)) = ref_grid(row(i),col(i)); %if it's still NaN, no problem anyway
	end
	%% RESAVE VARIABLES
	latest_I = this_I;
	save(refFilePath, 'ref_grid_surface', 'latest_I', '-append');
end

