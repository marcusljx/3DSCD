%TAKESCAN -- Takes a single scan of multiple frames and performs
%preprocessing.

function [dND, D, I] = s00_takeScan( N, crop_scale, downsample_scale )
	columns = crop_scale*320; 
	rows = crop_scale*240;
	
	[ D, I ] = Senz3D_capture_nFrames_avg( N );
	ndm = cropDepthMap(D, columns, rows);
	dND = resizem(ndm, downsample_scale);
end

