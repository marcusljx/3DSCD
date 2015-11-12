% DEPTH_MAP_DIFFERENCING -- Performs diff between two OPCs, and outputs deviations
%		*note: OPC dimensions and 1st and 2nd columns MUST MATCH.
%		INPUTS: P1, P2  {m x 3}
%		OUTPUTS: deviance_OPC {m x 3}

function deviance_OPC = OPC_diff( P1, P2 )
	if (size(P1) ~= size(P2))
		error('ERROR: dimensions do not match.');
	end
	
	deviance_OPC = P1;	% placeholder values
	deviance_OPC(:,3) = abs( P1(:,3) - P2(:,3) );
end

