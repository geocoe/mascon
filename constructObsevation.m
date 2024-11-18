function y=constructObsevation(cs_anomaly,maxDegree)
[cnm,snm]=separateCS(cs_anomaly);
y=zeros((maxDegree+1)*(maxDegree+2),1);
for i=1:maxDegree+1
    cmin=i*(i-1)/2+1;
    cmax=cmin+i-1;
    y(cmin:cmax)=cnm(i,1:i);
    smin=i*(i-1)/2+1+(maxDegree+1)*(maxDegree+2)/2;
    smax=smin+i-1;
    y(smin:smax)=snm(i,1:i);
end