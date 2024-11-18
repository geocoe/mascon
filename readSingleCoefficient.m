function [cnm, snm,maxDegree]=readSingleCoefficient(filename)
%addpath('D:\GRACE_SH_RL06_PL\GRACE_SH_RL06_PL\0 Data_used\CSR_RL06');
fid = fopen(filename);
hasErrors = true;
while 1                                                                     % read header 读取头文件信息，将重要参数赋给变量值
  line = fgetl(fid);
  if ~ischar(line), break, end
  if isempty(line), continue, end
  keyword = textscan(line,'%s',1);
  if(strcmp(keyword{1}, 'max_degree'))                                      % max_degree为最大阶数的标识符
    cells = textscan(line,'%s%d',1);
    maxDegree = cells{2};
  end
  if(strcmp(keyword{1}, 'radius'))                                          %radius为地球半径（平均）
    cells = textscan(line,'%s%f',1);
    R = cells{2};                                                           %提取半径的平均值
  end
  if(strcmp(keyword{1}, 'earth_gravity_constant'))                          %earth_gravity_constant为地球重力常数
    cells = textscan(line,'%s%f',1);
    GM = cells{2};                                                          %提取重力常数GM
  end
  if(strcmp(keyword{1}, 'tide_system'))                          
    cells = textscan(line,'%s%s',1);
    tide_system = cells{2};                                                 %潮汐系统
  end
  if(strcmp(keyword{1}, 'errors'))
    cells = textscan(line,'%s%s',1);
    if(strcmp(cells{2}, 'no'))                                              %文件中是formal,没有no
      hasErrors = false;
    end
  end
  if(strcmp(keyword{1}, 'end_of_head'))                                     %end_of_head头文件结束行的标志
    break
  end
end
% init the output matricies.结果输出
cnm = zeros(maxDegree+1, maxDegree+1);                                      %分配空间：产生最大阶数+1的矩阵来存放系数矩阵
snm = zeros(maxDegree+1, maxDegree+1);
while 1                                                                     % read potential coefficients 读取位系数
  line = fgetl(fid);
  if ~ischar(line), break, end
  if isempty(line), continue, end
  if(hasErrors)
    cells = textscan(line,'%s%d%d%f%f%f%f');
  else
    cells = textscan(line,'%s%d%d%f%f');
  end
  if ~isempty(cells)
      cnm(cells{2}+1, cells{3}+1) = cells{4};                                   %提取第四列C，放入第二列L+1、第三列M+1位置
      snm(cells{2}+1, cells{3}+1) = cells{5};                                   %提取第五列S，放入第二列L+1、第三列M+1位置
  end
 
end
fclose(fid);
% 物理参数和潮汐系统的统一
R_REF=6378136.3;GM_REF=3.986004415E14;
bias=4.173e-9;
for i=2:maxDegree

    fl=double((GM/GM_REF)*(R/R_REF)^i);    
    cnm(i+1,:)=cnm(i+1,:).*fl;
    snm(i+1,:)=snm(i+1,:).*fl;
    
end
if strcmp(tide_system,'zero_tide')
    cnm(3,1)=cnm(3,1)+bias;
end
