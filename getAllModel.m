function getAllModel(folderPath,outputFolderPath,targetDegree)
%% 读取文件夹中的所有的子文件夹
% 使用dir函数获取文件夹中的所有文件和子文件夹信息
folderContents = dir(folderPath);
numDirectory=length(folderContents);
numModel=numDirectory-2;
gravModels=cell(numModel,1);
% 计数器
t=0;
% 遍历文件夹内容
for i = 1:numDirectory
    % 忽略当前文件夹和上一级文件夹的条目
    if folderContents(i).isdir && ~strcmp(folderContents(i).name, '.') && ~strcmp(folderContents(i).name, '..')
        t=t+1;
        %为各机构时变重力场模型命名
        modelDirName=folderContents(i).name;
        modelName=strsplit(modelDirName,'_');
        mName=strcat(modelName{1},' SH');
        % 子文件夹的完整路径
        subFolderPath = fullfile(folderPath, modelDirName);
        % 读取某个时变重力场的球谐系数
        [shCS,dates,maxDegree]=getSingleModel(subFolderPath,targetDegree);

        %用字典存储一个模型的信息
        gravityModel.shCS=shCS;
        gravityModel.dates=dates;
        gravityModel.maxDegree=maxDegree;
        gravityModel.name=mName;
        gravModels{t}=gravityModel;
        disp(['第',num2str(i-2),'个模型，',mName,'读取完成']);
    end
end
disp('时变重力场读取完成');
%% 提取所有模型公共时间段数据
numModel=length(gravModels);
baseDate=gravModels{1}.dates;
for k=1:numModel
    modelDate=gravModels{k}.dates;
    tempDate=intersect(baseDate,modelDate);
    baseDate=tempDate;
    num=length(tempDate);
    disp(['交集个数',num2str(num)]);
end
for n=1:numModel
    %取出模型中的属性
    gModelShCS=gravModels{n}.shCS;
    gModelDates=gravModels{n}.dates;
    index=find(ismember(gModelDates,baseDate));
    %存储公共时间段的数据
    gravModels{n}.shCS=gModelShCS(:,:,index);
    gravModels{n}.dates=gModelDates(index);
    disp(['第',num2str(n),'个模型，',gravModels{n}.name,'遍历完成']);
end
disp('公共时间段数据提取完成');
%% 存储各模型
if ~exist(outputFolderPath,'dir')
    mkdir(outputFolderPath);
end
% 构建完整的存储路径
outputFilePath = fullfile(outputFolderPath,"gravityModels.mat");
save(outputFilePath,"gravModels");
disp('数据存储完成');

