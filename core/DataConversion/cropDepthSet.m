function newSet = cropDepthSet( Depth_Set, sizeX, sizeY )
	[~,~,N] = size( Depth_Set );
	newSet = [];
	for i=1:N
		crop_dm = cropDepthMap(Depth_Set(:,:,i), sizeX, sizeY);
		newSet = cat(3,newSet, crop_dm);
	end
end

