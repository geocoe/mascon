function [doys]=date2doy(dates)
ndate=length(dates);
doys=zeros(ndate,1);
for i=1:ndate
    dateTime=datetime(dates{i},"InputFormat","yyyy-MM");
    dateTime.Day=dateTime.Day+14;
    year=dateTime.Year;
    dateNum=datenum(dateTime);
    startYear=datenum(datestr(dateNum,"yyyy-01-01"));
    dayOfYear=dateNum-startYear+1;
    % 判断是否是闰年
    if (mod(year,100)~=0 && mod(year,4)==0)||mod(year,400)==0        
        daysPerYear=366;
    else
        daysPerYear=365;
    end
    doy=dayOfYear/daysPerYear;
    decimalYear=year+doy;
    doys(i)=decimalYear;
end