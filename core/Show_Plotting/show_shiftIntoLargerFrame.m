function fig_handle = show_shiftIntoLargerFrame( origD_ref, origD_curr, curr_grid, M, N )
	fig_handle = figure;

	subplot(2,2,1); h1=show_depthmap_relative(origD_ref); title('orig_ref');
	subplot(2,2,3); h3=show_depthmap_relative(origD_curr); title('orig_this');
	subplot(2,2,4); h4=show_depthmap_relative(curr_grid); title('regCombined_this');
end

