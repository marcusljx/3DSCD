function variance = getVarianceInPatch( binDev, absDev )
    [m,n] = size(absDev);
    binDev(isnan(binDev)) = 0;
    absDev(absDev==0) = nan;
    area = sum(sum(binDev));

    covPoints = zeros(1,area);

    i=1;
    for x=1:m
       for y=1:n
          if(~isnan(absDev(x,y)))
              covPoints(i) = absDev(x,y);
              i=i+1;
          end
       end
    end

    if(size(covPoints,2) == 0)
        variance = 0;
    else
        variance = cov(covPoints) * (max(covPoints) - min(covPoints));
    end
end