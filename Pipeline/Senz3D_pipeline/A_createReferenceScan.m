%CREATEREFERENCESCAN -- Captures a surface and saves it as a reference
%	PIPELINE:
%		1. Captures n frames and finds the average of each point
%		2. Performs 2.5d_MLS on surface
%		3. Saves 2.5D Surface in variable

% INPUT:
%		N								[scalar] number of frames to take average scan
%		refFileName			[string] the filename to store this surface reference under

function [ref_grid_surface, ref_dND, latest_I] = A_createReferenceScan( frames, refFilePath, mls_h )
	%% SET INITIALISERS
	crop_scale = 0.5;				% leave as default
	downsample_scale = 0.7;	% leave as default
	
	%% GRAB FRAME + preprocessing
	[ref_dND, ~, latest_I] = s00_takeScan(frames, crop_scale, downsample_scale);
	ref_grid_surface = ref_dND;
	
	%% VARIABLES
	save(refFilePath, 'frames', 'ref_grid_surface', 'latest_I', 'crop_scale', 'downsample_scale', 'mls_h');
end

