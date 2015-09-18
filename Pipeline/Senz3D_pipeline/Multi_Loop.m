clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));


%% START LOOP
noc = 5; e=1;

IMG{noc} = [];
REFs{noc} = [];
CURs{noc} = [];
DIFF{noc} = [];
SURF{noc} = [];

FIG_LOOP = figure;
Wk5_demo_Pipeline_Part1;

IMG{e} = I;
SURF{e} = ref;

for e = 2:noc
	Wk5_demo_Pipeline_Part2;
	dev = abs(ref_grid - curr_grid);
	
	%% SHOW PLOTS
	img_name = sprintf('I-%i', e-1);
	subplot(3,noc,e), imshow(this_I); title(img_name);
	
	dev_name = sprintf('dev-%i', e-1);
	subplot(3,noc,noc+e), show_depthmap_relative(dev); title(dev_name);
	
	load(SurfaceStoragePath);
	combi_name = sprintf('combi-%i',e-1);
	subplot(3,noc,2*noc+e), show_depthmap_relative(ref_grid_surface); title(combi_name);
	
	%% SAVE VARIABLE
	IMG{e} = this_I;
	REFs{e} = ref_grid;
	CURs{e} = curr_grid;
	DIFF{e} = dev;
	SURF{e} = ref_grid_surface;
end