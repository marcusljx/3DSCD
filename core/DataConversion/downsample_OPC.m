%% uses matlab pointcloud downsampling function to downsample an organised point cloud
function output_OPC = downsample_OPC( input_OPC, gridStep )
	input_OPC = cast(input_OPC, 'double');	%convert to double (required)
	cloud_object = pointCloud(input_OPC);
	ds_cloud_object = pcdownsample(cloud_object,'gridAverage',gridStep);
	output_OPC = ds_cloud_object.Location;
end

