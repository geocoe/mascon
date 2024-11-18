function [shCS,dates,maxDegree]=getSingleModel(folderPath,targetDegree)
namelist=dir(fullfile(folderPath,'*.gfc'));
len=length(namelist);
shCS=[];
dates={};
k=0;
for i=1:len

    %正则表达式提取时间信息
    %三大官方机构的时间提取
    match1=regexp(namelist(i).name,'\d{7}','match');
    %ITSG和Tongji的时间提取
    match2=regexp(namelist(i).name,'\d{4}-\d{2}.gfc','match');
    %SWPU的时间提取
    match3=regexp(namelist(i).name,'\d{6}_96','match');
    %AIUB的时间提取
    match4=regexp(namelist(i).name,'\d{4}_\d{2}.gfc','match');
    if ~isempty(match1)
        string1=match1{1};
        string0=match1{2};
        %提取年份和天数
        startYear=str2double(string1(1:4));
        startDay=str2double(string1(5:7));
        endYear=str2double(string0(1:4));
        endDay=str2double(string0(5:7));
        %计算日期序列
        startDate=datetime(startYear,1,1)+days(startDay-1);
        startDateNum=datenum(startDate);
        endDate=datetime(endYear,1,1)+days(endDay-1);
        endDateNum=datenum(endDate);
        %计算中间日期
        midDateNum=(startDateNum+endDateNum)/2;
        midDate=datetime(midDateNum,"ConvertFrom","datenum");
        %提取年份,月份
        month=str2double(datestr(midDate,'mm'));
        year=str2double(datestr(midDate,'yyyy'));

    elseif ~isempty(match2)
        string2=match2{1};
        %提取年份和月份
        year=str2double(string2(1:4));
        month=str2double(string2(6:7));
    elseif ~isempty(match3)
        string3=match3{1};
        %提取年份和月份
        year=str2double(string3(1:4));
        month=str2double(string3(5:6));
    elseif ~isempty(match4)
        string4=match4{1};
        str_year=['20',string4(1:2)];
        year=str2double(str_year);
        month=str2double(string4(3:4));

    end
    % 使用 sprintf 进行字符串格式化
    date = sprintf('%d-%02d', year, month);
    
    %读取单个模型的球谐系数
    [cmn,smn,maxDegree]=readSingleCoefficient(fullfile(namelist(i).folder,namelist(i).name));
    if maxDegree<targetDegree
        continue;
    end
    % 计数器计数
    k=k+1;
    %将C,S转换为一个矩阵|C\S|
    for j=1:maxDegree
        cmn(j,j+1:maxDegree+1)=smn(j+1:maxDegree+1,j+1);
    end
    
    shCS(:,:,k)=cmn;
    dates{k}=date;
   
end
% 纠正重复的时间点
for j = 1:(length(dates) - 1)
    if strcmp(dates(j + 1), dates(j))
        ori_date = datetime(dates{j + 1}, 'InputFormat', 'yyyy-MM');
        % 将 datetime 转换为序列化的日期数值
        % serial_date = datenum(ori_date);
        month = ori_date.Month + 1;

        if month > 12
            %new_serial_date = addtodate(serial_date, 1, 'year');
            %new_date = datetime(new_serial_date, 'ConvertFrom', 'datenum');
            yearOfDate=ori_date.Year+1;
            monthOfDate=mod(month,12);
        else
            %new_serial_date = addtodate(serial_date, 1, 'month');
            %new_date = datetime(new_serial_date, 'ConvertFrom', 'datenum');
            yearOfDate=ori_date.Year;
            monthOfDate=month;
        end
        dates{j + 1} = sprintf('%d-%02d',yearOfDate,monthOfDate);
    end
end