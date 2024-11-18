function cs_anomaly=removeBaseline(cs,time,startYear,endYear)
if startYear>=endYear
    error('起始年限需要小于终止年限，程序退出');
else
    if startYear<=2004&&endYear>=2010
        indices=find((time>=2004)&(time<=2010));
    else
        indices=find((time>=startYear)&(time<=endYear));
    end

    if isempty(indices)
        cs_anomaly=cs-mean(cs,3);
    else
        csMean=mean(cs(:,:,indices),3);
        cs_anomaly=cs-csMean;
    end

end