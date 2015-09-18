function D = invertArrayValues( D )
	mx = max(max(D));
	mn = min(min(D));
	
	D = (mx+mn) - D;

end

