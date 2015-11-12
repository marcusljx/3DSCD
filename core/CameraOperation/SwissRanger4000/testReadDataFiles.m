clear
clc
filePrefix1 = 'test';
filePrefix2 = 'test2';

%% READ FILE
[~, ~, D1, C1] = SR4K_readScan(filePrefix1);
[~, ~, D2, C2] = SR4K_readScan(filePrefix2);
% CD1 = imresize(D1 .* C1, 0.5);
% CD2 = imresize(D2 .* C2, 0.5);

%% PLOT
plot_rows = 3;
plot_cols = 2;
figmain = figure;
subplot(plot_rows,plot_cols,1); h1=show_depthmap_relative(D1); title('1ST VIEW');
subplot(plot_rows,plot_cols,2); h2=show_depthmap_relative(D2); title('2ND VIEW');
subplot(plot_rows,plot_cols,3); h3=show_depthmap_relative(C1); title('Confidence 1');
subplot(plot_rows,plot_cols,4); h4=show_depthmap_relative(C2); title('Confidence 2');

subplot(plot_rows,plot_cols,5); h5=show_depthmap_relative(CD1); title('CD1');
subplot(plot_rows,plot_cols,6); h6=show_depthmap_relative(CD2); title('CD2');

colormap('jet');