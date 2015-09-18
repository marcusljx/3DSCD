function handle = show_binaryMap( input )
	cmap = [	0.0, 0.0, 0.5;	...	% blue
						1.0, 0.0, 0.0;	...	% red
					];
	handle = imshow(input);
	colormap(cmap);
	freezeColors;
end

