function newD = cropDepthMap( Depth_data, columns, rows )
	[m,n,~] = size(Depth_data);
	
	%cutaway
	newD = Depth_data;
	cutoff_y = (m-rows)/2;
	cutoff_x = (n-columns)/2;
	
	%cut top and bottom
	newD((m-cutoff_y+1):m,:, :) = [];
	newD(1:cutoff_y,:, :) = [];
	
	%cut left and right
	newD(:, (n-cutoff_x+1):n, :) = [];
	newD(:, 1:cutoff_x, :) = [];
end

