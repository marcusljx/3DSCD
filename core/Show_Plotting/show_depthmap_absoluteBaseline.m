function handle = show_depthmap_absoluteBaseline( input, threshold )
	baseline = min(min(input));
	handle = imshow(input, [baseline, baseline+threshold]);
	colormap('jet');
	freezeColors;
end

