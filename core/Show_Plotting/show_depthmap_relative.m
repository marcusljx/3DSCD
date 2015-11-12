function handle = show_depthmap_relative( input )
	cdev = input;
	cmax = max(max(cdev));
	cmin = min(min(cdev));
	
	cdev(cdev == 0) = nan;

	handle = imshow(cdev, [cmin, cmax]);
	newcmap = colormap('jet');
    newcmap(1,3) = 0;
    colormap(newcmap);
	freezeColors;
end

