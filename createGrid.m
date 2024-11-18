close;
clc;
clear;

[lat,lon]=GridSphere(10242);

outputFolderPath='D:\code\point mass\data';
if ~exist(outputFolderPath,'dir')
    mkdir(outputFolderPath);
end
% 构建完整的存储路径

outputFilePath = fullfile(outputFolderPath,"Location.mat");
save(outputFilePath,"lat","lon");
disp(['数据存储到:',outputFilePath]);