function handle = show_depthmap_relative( input )
	handle = imshow(input, [min(min(input)), max(max(input))]);
	colormap('jet');
	freezeColors;
end

