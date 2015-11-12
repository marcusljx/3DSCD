function figHandle = experiment_viewRDS( isSENZ3D, IMGs, REFs, ROMIref, ROMIthis, SURF, names, diffType, diffViewType, thresh )
	n = size(REFs,2);

	if( (size(ROMIref,2) ~= n) || (size(ROMIthis,2) ~= n) || (size(SURF,2) ~= n) )
		error('sizes of input arguments do not match.');
	end
	
	figHandle = figure;
	
	for i=1:n
		dev = dDiff(ROMIref{i}, ROMIthis{i}, diffType, thresh);
		
		if(isSENZ3D)
			subplot(3,n,i), h1=imshow(IMGs{i}); title('I');
		else %SR4K
			subplot(3,n,i), h1=show_depthmap_relative(IMGs{i}); title('I');
		end
		subplot(3,n,(2*n+i)), h3=show_depthmap_relative(SURF{i}); title('combined');
		
		switch diffViewType
			case 'relative'
				subplot(3,n,n+i), h2=show_depthmap_relative(dev); title(names{i});
				
			case 'absolute'
				subplot(3,n,n+i), h2=show_depthmap_absoluteBaseline(dev, 20); title(names{i});
			
			case 'binary'
				subplot(3,n,n+i), h2=show_binaryMap(dev); title(names{i});
		end
	end	
end