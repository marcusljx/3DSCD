mls_h = 10;
icp_tol = 1e-3;

i = 2;

[ ROMI_ref, ROMI_this ] = SR4K_compare2surfaces( SURF{i}, REFs{i+1}, mls_h, icp_tol );
ROMIref{i+1} = ROMI_ref;
ROMIthis{i+1} = ROMI_this;

figure;
subplot(2,2,1), showPointCloud(depth2OrganizedPointCloud(ROMI_ref));
subplot(2,2,2), showPointCloud(depth2OrganizedPointCloud(ROMI_this));

dev = dDiff(ROMI_ref, ROMI_this, 'absolute');
t=sprintf('h = %d', mls_h);
subplot(2,2,[3,4]), h2=show_depthmap_relative(dev); title(t);