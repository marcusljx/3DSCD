% THIS SCRIPT SHOWS THE RESULTS OF IMG/DIFF/SURF
load('F:\Matlab_Home_HonsLab_sync\PIPELINE_program\Vars\MultiAngle_WithChange.mat');

noc = size(IMG,2);
depth_threshold = 100;

for i=1:noc
	e = i-1;
	img_name = sprintf('I-%i', e);
	dev_name = sprintf('dev-%i', e);
	combi_name = sprintf('combi-%i', e);
	
	subplot(3,noc,i), imshow(IMG{i}); title(img_name);
	subplot(3,noc,noc+i), show_depthmap_absoluteBaseline(dev, depth_threshold); title(dev_name);
	subplot(3,noc,2*noc+i), show_depthmap_absoluteBaseline(ref_grid_surface, depth_threshold); title(combi_name);
end