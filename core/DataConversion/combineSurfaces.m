function surface = combineSurfaces( ref, addition )
	if(size(ref) ~= size(addition))
		error('sizes of input arguments do not match.');
	end

	%% use all new points
	surface = addition;
	
	%% overwrite missing points with older points
	[row, col] = find( isnan( surface ));
	for i = 1:size(row,1)
		surface(row(i), col(i)) = ref(row(i), col(i));
	end
end

