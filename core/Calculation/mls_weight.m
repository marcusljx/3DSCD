function result = mls_weight( d, h )
% standard MLS weight function
	result = exp( -( d.^2 / h^2 ) );
end

