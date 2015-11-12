s3d_full = unique([s3d_full; FPR_TPR], 'rows')
plot(s3d_full(:,1), s3d_full(:,2));

SENZ3D_FPR_TPR = s3d_full;

save(savePath, 'SENZ3D_FPR_TPR');