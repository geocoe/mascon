function masconFittingEnsemble(gravity_dir_path,type,numUnknown,outputFolderPath)
%% 加载球谐系数
filename=dir(fullfile(gravity_dir_path,'*.mat'));
gravity_model_name=filename.name;
load(fullfile(gravity_dir_path,gravity_model_name));
latitude=[];
longitude=[];
%% 进行mascon拟合法计算
if strcmp(type,'single')
    disp('对单个模型进行mascon拟合法计算');
    % 读取单个重力场模型
    singleModel=gravModels{2};
    cs=singleModel.shCS;
    dates=singleModel.dates;
    maxDegree=double(singleModel.maxDegree);
    mName=singleModel.name;
    time=date2doy(dates);
    numEpoch=1;
    %numEpoch=length(time);
    % 构造系数矩阵
    [A,lat,lon]=coefficient_matrix(maxDegree,numUnknown);
    latitude=lat;
    longitude=lon;
    disp('系数矩阵构造完成');
    N_one = A'*A;
    % 去除2004.000~2009.999平均场
    cs_anomalies=removeBaseline(cs,time,2004,2010);
    disp('平均场扣除完成，得到系数异常');
    % 为各个月份单位权方差和TWSA分配空间
    sitaAllMonth=zeros(2,numEpoch);
    xAllMonth=zeros(numUnknown,numEpoch);
    varianceAllMonth=zeros(2,numEpoch);
    for i=1:numEpoch
        cs_anomaly=cs_anomalies(:,:,i);
        % 构建观测值
        y=constructObsevation(cs_anomaly,maxDegree);
        numObs=length(y);
        disp('观测值构建完成');
        % 初始化单位权方差
        sita=ones(2,1);
        variance=ones(2,1);
        variance(2)=1e27;
        R=eye(numUnknown,numUnknown);
        % 迭代器
        t=0;
        while 1
            t=t+1;
            W=sita(1)./variance;
            Nb=W(1)*N_one;
            NR=W(2)*R;
            N=Nb+NR;
            b=W(1)*(A'*y);
            disp('法方程构建完成');
            % 求解正则化解
            x=N\b;
            disp('正则化解求解完成');
            v=A*x-y;
            sita(1)=W(1)*(v'*v)/(numObs-trace(Nb/N));
            sita(2)=W(2)*(x'*x)/(numUnknown-trace(NR/N));
            disp('验后单位权方差计算完成');
            endCondition=abs(max(sita)/min(sita)-1);
            if endCondition<0.1 || t>20
                sitaAllMonth(:,i)=sita;
                xAllMonth(:,i)=x;
                varianceAllMonth(:,i)=variance;
                disp(['迭代完成，迭代次数为:',num2str(t)]);
                disp(['验后单位权方差为:',num2str(sita(1)),':',num2str(sita(2))]);
                disp(['方差为:',num2str(variance(1)),',',num2str(variance(2))]);
                disp(['迭代完成时，收敛到',num2str(endCondition)]);
                break;
            else
                variance=sita./W;
                disp(['第',num2str(t),'次迭代未收敛，继续迭代']);
            end
        end
    end
end
%% 存储数据
TWSA.sita=sitaAllMonth;
TWSA.TWSA=xAllMonth;
TWSA.variance=varianceAllMonth;
TWSA.longitude=longitude;
TWSA.latitude=latitude;
if ~exist(outputFolderPath,'dir')
    mkdir(outputFolderPath);
end
% 构建完整的存储路径
outputFilePath = fullfile(outputFolderPath,"MasconFitting.mat");
save(outputFilePath,"TWSA");
disp('数据存储完成');
disp('')
