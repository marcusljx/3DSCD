% METHOD TAKEN FROM
% http://www.csse.uwa.edu.au/~ajmal/code/icp.m

function [ R, t, corr, q ] = ICP(p, q, tol)
	%initialise
	c1 = 0;
	c2 = 1;
	
	R = eye(3,3);
	t = zeros(3,1);
	
	fprintf('Doing Delaunay triangulation:...');
	tri = delaunayn(p'); fprintf('DONE\n');
	
	counter=0;
	while( c2 > c1 )
		tic
		c1 = c2;
		%match_bruteForce
% 		[matchSet, minDist] = icp_match(q,p);
		fprintf('Doing Delaunay Search:...');
		[corr, minDist] = dsearchn(p', tri, q');fprintf('DONE\n');

		corr(:,2) = [1 : length(corr)]';

		%empty those that are above the theshold
		ii = find( minDist > tol);
		corr(ii,:) = [];

		%match q to p
		fprintf('Doing Registration:...');
		[R1, t1] = icp_register(p,q, corr);fprintf('DONE\n');
		q = R1*q;
		q = [	q(1,:) + t1(1);	...
					q(2,:) + t1(2);	...
					q(3,:) + t1(3);	...
					];

		%calculate R and t
		R = R1*R;
		t = R1*t + t1;

		%loop to finish
		c2 = length(corr);
		
		%CHECKING
		counter = counter+1;	
		fprintf('count=%i \t',counter), toc, fprintf('\n');
	end
end

