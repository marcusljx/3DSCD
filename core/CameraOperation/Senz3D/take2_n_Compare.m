clc
clear
addpath(genpath('F:\Matlab_Home_HonsLab_sync'));

%% OBTAIN TWO FRAMES OF RGBD DATA
[DEPTH1, IMG1, DEPTH2, IMG2] = getCamera_2frames();

%% IMMEDIATE FRAME DIFFERENCE
DIRECT_DIFFERENCE = abs(DEPTH1 - DEPTH2);

%% CONVERT TO POINT CLOUDS
P1 = depth2OrganizedPointCloud(DEPTH1);
P2 = depth2OrganizedPointCloud(DEPTH2);

%% PLOT
fig_inputs = figure(1); hold off;
% subplot(2,2,1), d1 = 