clear
clc

graphs{9} = []; gg=1;
for cThresh = 0.1:0.1:0.9;
	resultFolder = strcat(pwd,'\Pipeline\mls_Experiment\mls_exp_results\');
	dirstruct = dir(strcat(resultFolder,'*.mat'));
	iii=1;

	result = zeros(size(dirstruct,1),2);

	for h=0:0.1:3.9
		load(dirstruct(iii).name);

		dev = abs(ROMIref{2} - ROMIthis{2});
		t_theta = min(min(dev)) + cThresh*(max(max(dev)) - min(min(dev)));

		result(iii,1) = h;
		result(iii,2) = sum(sum(dev >= t_theta));
		iii=iii+1;
	end
	
	graphs{gg} = result;
	gg = gg+1;
end

clearvars -except 'graphs' 'graphLegend'

%% PLOT RESULTS
figmain = figure;
hold on;
for i=1:size(graphs,2)
	P=graphs{i};
	plot(P(:,1), P(:,2), 'LineWidth', 2);
end

title('Rate of Pixels Indicating "Change" over different Gaussian Parameters h');

graphLegend = {	...
	'10% Change Threshold'	...
	'20% Change Threshold'	...
	'30% Change Threshold'	...
	'40% Change Threshold'	...
	'50% Change Threshold'	...
	'60% Change Threshold'	...
	'70% Change Threshold'	...
	'80% Change Threshold'	...
	'90% Change Threshold'	...
};
legend(graphLegend);

xaxisname = sprintf('MLS Guassian Parameter h');
yaxisname = sprintf('# of Pixels Indicating Change');
xlabel(xaxisname);
ylabel(yaxisname);