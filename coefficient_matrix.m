function [coe1,latitude,longitude]=coefficient_matrix(maxDegree,numUnknown)

% 设置地球物理常数
a = 6378136.3;
gm = 3.986004415e14;
G = 6.67259e-11;
earth_mass = gm / G;
s = 4*pi/numUnknown;

% 获取负荷勒夫系数
kl=lovenums(maxDegree);
% 获取质量块位置
[latitude,longitude]=GridSphere(numUnknown);
% 将度转换为弧度
latRad=deg2rad(latitude);
lonRad=deg2rad(longitude);
m=double((0:1:maxDegree));
ccos=cos(m.*lonRad)';
ssin=sin(m.*lonRad)';
% 勒让德函数
Pnm0=plm_holmes(maxDegree,sin(latRad));
% Pnm0=Legendre_PL(maxDegree,length(latRad),latRad);
% 常数项
costant1=zeros(maxDegree+1,1);
for i=1:1:maxDegree+1
    costant1(i)=10.25*(1+kl(i))*a^2/(earth_mass*(2*i+1))*s;
end
% 构造系数
col = (maxDegree + 2) * (maxDegree + 1);
coe1 = zeros(col,numUnknown);
for i=1:1:maxDegree+1
    P1=reshape(Pnm0(i,1:i,:),[i,numUnknown]);
    cmin=i*(i-1)/2+1;
    cmax=cmin+i-1;
    coe1(cmin:cmax,:)=costant1(i)*P1.*ccos(1:i,:);
    smin=i*(i-1)/2+1+col/2;
    smax=smin+i-1;
    coe1(smin:smax,:)=costant1(i)*P1.*ssin(1:i,:);
end
disp('');