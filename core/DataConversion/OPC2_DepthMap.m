% OPC2_DEPTHMAP -- CONVERTS OPC BACK TO DEPTHMAP
%		*NOTE: OPC MUST NOT HAVE MISSING ELEMENTS
function Depthmap = OPC2_DepthMap( OPC, m, n )
% 	if (size(OPC,1) ~= (m*n))
% 		error('ERROR: OPC dimensions do not match expected output grid.')
% 	end

	Depthmap = nan(m,n);
	for i = 1:size(OPC,1)
		x = OPC(i,1);
		y = OPC(i,2);
		
		Depthmap(x,y) = OPC(i,3);
	end
end

