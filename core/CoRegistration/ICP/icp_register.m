function [ R, t ] = icp_register( p1, p2, corr )
	n = length(corr);
	
	%points in p1 that matched
	MODEL = p1(:, corr(:,1));
	modelMean = mean(MODEL,2);
	
	%points in p2 that matched
	SET = p2(:, corr(:,2));
	setMean = mean(SET,2);
	
	SET_Shifted = [	SET(1,:)-setMean(1);	...
									SET(2,:)-setMean(2);	...
									SET(3,:)-setMean(3);	...
									];
								
	MODEL_Shifted = [	MODEL(1,:)-modelMean(1);	...
										MODEL(2,:)-modelMean(2);	...
										MODEL(3,:)-modelMean(3);	...
										];

	%average
	K = (SET_Shifted * MODEL_Shifted') / n;
	
	%SVD
	[U, S, V] = svd(K);
	
	R = V*U';
	if ( det(R)<0 )
		B = eye(3);
		B(3,3) = det(R);
		R = V*B*U;
	end
	
	t = modelMean - (R* setMean);
end

