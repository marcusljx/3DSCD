function [ d1, d2, I1, I2] = Senz3D_capture_long2( N )
	
	input('Press Enter to Capture 1:\n');
		[ d1, I1 ] = Senz3D_capture_nFrames_avg( N );
	input('Press Enter to Capture 2:\n');
		[ d2, I2 ] = Senz3D_capture_nFrames_avg( N );
end