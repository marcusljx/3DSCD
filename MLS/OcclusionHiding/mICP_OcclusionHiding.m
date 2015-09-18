%% DO INIT

	% in event where init not required, just run this script after the init script	
%% USING MATLAB'S POINT CLOUD REGISTRATION METHOD
pcP1 = pointCloud( depth2OrganizedPointCloud( dND1 ) );
pcP2 = pointCloud( depth2OrganizedPointCloud( dND2 ) );

[tform,regpcP2] = pcregrigid(pcP2,pcP1);

P1 = pcP1.Location;
P2 = pcP2.Location;
RP2 = regpcP2.Location;

%% INTERPOLATE FP2 DATA ONTO P1 SPACE
[outSizeX, outSizeY] = size(dND1);

[xq1, yq1, vq1] = scatteredOPC_2_mesh(P1,1, outSizeX, outSizeY);
[xq2, yq2, vq2] = scatteredOPC_2_mesh(RP2,1, outSizeX, outSizeY);

%% INVALIDATE OCCLUSION OF VQ2 FROM FP2
sub_vq2 = rot90(fliplr(vq2),1);
invalid_dist = sqrt(0.5);
newVQ2 = invalidate_occlusion(sub_vq2, RP2, invalid_dist);

newVQ2 = rot90(newVQ2,2);
vq1 = rot90(fliplr(vq1),3);

%% DIFFERENCE NEWVQ WITH VQ1
dev = abs(vq1 - newVQ2);

%% PLOT
fig_main = figure;
subplot(1,3,1), h1=showPointCloud(P1, 'b'); title('pcP1');
subplot(1,3,2), h2=showPointCloud(RP2, 'r'); title('pcP2');

subplot(1,3,3), h3=showPointCloud(P1, 'b'); hold on;
	showPointCloud(RP2, 'g'); title('registered');

	fig_disp = figure;
subplot(2,3,1), imshow(I1); title('Before');
subplot(2,3,4), imshow(I2); title('After');
subplot(2,3,2), hvq1=imshow(vq1, [min(min(vq1)),max(max(vq1))]); title('vq1');
subplot(2,3,3), hvq2=imshow(vq2, [min(min(vq2)),max(max(vq2))]); title('vq2');
subplot(2,3,5), hnewVQ2=imshow(newVQ2, [min(min(newVQ2)),max(max(newVQ2))]); title('newVQ2');
subplot(2,3,6), hdev=imshow(dev, [min(min(dev)),max(max(dev))]); title('dev');
colormap('jet');