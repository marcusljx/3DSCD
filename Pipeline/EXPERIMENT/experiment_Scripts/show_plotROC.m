clear
clc

generic = {'SR4K_Y', 'SR4K_nonopt_Y'};


files1 = {	strcat(generic{1}, '_1', 'p.mat'), ...
						strcat(generic{2}, '_1', 'p.mat'), ...
					};

files2 = {	strcat(generic{1}, '_0.25', 'p.mat'), ...
						strcat(generic{2}, '_0.25', 'p.mat'), ...
					};
				
files3 = {	strcat(generic{1}, '_0.50', 'p.mat'), ...
						strcat(generic{2}, '_0.50', 'p.mat'), ...
					};
				
files4 = {	strcat(generic{1}, '_0.75', 'p.mat'), ...
						strcat(generic{2}, '_0.75', 'p.mat'), ...
					};

names = {   ...
		'1 Pixel' ...
		'25%', ...
		'50%', ...
		'75%', ...
		};

% if(strcmp(pThresh{i},'1'))
% 		title = 'ROC:  Single Pixel Threshold';
% else
% 		title = strcat('ROC: ', sprintf(' %s pixel threshold',pThresh{i}));
% end

title = 'Effect of Optimal/Non-Optimal Alignment on Performance';
title = sprintf('%s\n(percentages refer to amount of pixels in entire changemap that signify "change")', title);

figmain = figure; hold on;

subplot(2,2,1), h1=show_subplotROC(files1, generic, names{1});
subplot(2,2,2), h2=show_subplotROC(files2, generic, names{2});
subplot(2,2,3), h3=show_subplotROC(files3, generic, names{3});
subplot(2,2,4), h4=show_subplotROC(files4, generic, names{4});

suptitle(title);