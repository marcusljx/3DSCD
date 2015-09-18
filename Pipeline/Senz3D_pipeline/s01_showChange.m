function dev = s01_showChange( figWindow, ref_grid, curr_grid, I_ref, I_next, crop_scale )
	%% FIND DIFFERENCE
	dev = abs(ref_grid - curr_grid);

	%% CALCULATE VALUES
	x_box = [	(0.5*crop_scale * 320), ...
						640 - (0.5*crop_scale * 320), ...
						(0.5*crop_scale * 240), ...
						480 - (0.5*crop_scale * 240)
					];	% [x_begin, x_end, y_begin, y_end]
	x_colorbox = [x_box(1), x_box(3), x_box(2)-x_box(1), x_box(4)-x_box(3)];

	permaMax = 30.0;
	permaMin = 0.0;
	
	%% SHOW PLOTS
	fig_disp = figure(figWindow);
	set(fig_disp, 'Position', [0, 0, 1920, 1080]);
	
	% rgb images
	subplot(2,3,1), imshow(I_ref); title('Previous Scan');hold on;
	rectangle('position',x_colorbox, 'edgecolor','b'); hold off;
	subplot(2,3,4), imshow(I_next); title('Current Scan');hold on;
	rectangle('position',x_colorbox, 'edgecolor','b'); hold off;
	
	% depth scans
	subplot(2,3,2), hV1=show_depthmap_relative(ref_grid); title('Previous Scans Merged');
	subplot(2,3,5), hV2=show_depthmap_relative(curr_grid); title('Current Scan');

	% difference
	subplot(2,3,3), hD=show_depthmap_relative(dev); title('Raw Difference');
	
% 	subplot(2,3,6), hD=imshow(dev, [min(min(dev)), max(max(dev))]); title('Relative Difference');
	
	
	
% 	% smoothened difference
%		tic; G = gridMLS(dev, 15); toc
% 	subplot(2,3,6), hD=imshow(G, [permaMin, permaMax]); title('Smoothened Difference');
end

