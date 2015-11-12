%MULTIPLE_MLS_2P5D Summary of this function goes here
%   Detailed explanation goes here

function mlsD1 = MLS_2p5D_multiple( D, P, h )
	[M,N] = size(D);
	mlsD1 = zeros(M,N);
	
	parfor i=1:M
		for j=1:N
				r = [i, j, D(i,j)];
			if( ~isnan(r) )
				q = MLS_2p5D_single(P, r, h);
				mlsD1(i,j) = q(3);
			else
				mlsD1(i,j) = nan;
			end
		end
		fprintf('i=%i complete\n',i);
	end

end

