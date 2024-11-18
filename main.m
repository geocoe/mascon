clc;
close;
clear;
% 程序开始时间
tic;
disp('程序开始运行');
%% 文件路径获取
% 获取json文件路径
currentFilePath=mfilename('fullpath');
[currentDirectoryPath,~,~]=fileparts(currentFilePath);
jsonPath=fullfile(currentDirectoryPath,'point_mass.json');

% 读取JSON文件内容
jsonText = fileread(jsonPath);
 
% 解析JSON文件
jsonData = jsondecode(jsonText);
console=jsonData.Console;
entranceChoice=selectFromTemvalue(console);

% 访问解析后的数据
SH_path=jsonData.Inputfilepath{1}.SH_path;
gravity_path=jsonData.Outputfilepath{3}.gravity_path;
targetDegree=jsonData.Inputparameter{2}.value;
mascon_path=jsonData.Outputfilepath{1}.mascon_path;
caculate_type=jsonData.Inputparameter{1};
numUnknown=jsonData.Inputparameter{3}.value;

% 检查文件路径
SH_path=pathCheck(SH_path);
mascon_path=pathCheck(mascon_path);
gravity_path=pathCheck(gravity_path);
caculate_type=selectFromTemvalue(caculate_type);

%% 程序运行入口
if strcmp(entranceChoice,'preprocess')
    % 球谐系数读取入口
    getAllModel(SH_path,gravity_path,targetDegree);
elseif strcmp(entranceChoice,'masconfit')
    % mascon拟合法入口
    % mascon_fit_emsenble(gravity_path,caculate_type,numUnknown,mascon_path);
    masconFittingEnsemble(gravity_path,caculate_type,numUnknown,mascon_path);
elseif strcmp(entranceChoice,'visualization')
    disp('');
end

%% 程序运行结束时间
timeElapsed=toc;
timeElapsedShow(timeElapsed);


