%Ditmar, 2018, journal of geodynamics, experiment
clc
clear
% rng(1);
t=0:3/36:3;
A=1;C=0.5;
H=A*sin(2*pi*t)+C*t;
B=zeros(24,37);
B(1:24,1:24)=eye(24);
% d=H(1:24)'+0+1*randn(24,1);
d=H(1:24)'+normrnd(0,1,[24,1]);
D=zeros(24,37);
for i=1:24
    D(i,i)=1;
    D(i,i+1)=-1;
    D(i,i+12)=-1;
    D(i,i+13)=1;
end
sigmad2=1;
sigmax2=1;
P1=eye(24);
P2=eye(24);
n=24;
m=24;

i=0;
while(1)
    i=i+1;
%     Nd=(B'*P1*B)/sigmad2;
    Nd=(B'*P1*B);
    R=D'*P2*D;
%     Nx=R/sigmax2;
    Nx=R;
    N=Nd+Nx;
    NI=inv(N);
%     x=(NI*B'*P1*d)/sigmad2;
    x=(NI*B'*P1*d);
    taod=trace(Nd*NI);
    taox=trace(Nx*NI);
    vd=d-B*x;
    sigmad2=(vd'*P1*vd)/(n-taod);
    sigmax2=(x'*R*x)/(m-taox);
    if(abs(sigmad2/sigmax2-1)<1e-2||i>50) 
        break;
    end
    P1=P1/sigmad2;
    P2=P2/sigmax2;
%     pause
end
plot(t,x,'r','LineWidth',5);
hold on;
plot(t(1:24),d,'o','MarkerSize',10);
hold on;
plot(t,H,'k','LineWidth',2)
hold on;
legend('计算值','观测值','真值');
Dd=sigmad2*inv(P1);
sigmad=sqrt(Dd);
Dx=sigmax2*inv(P2);
sigmax=sqrt(Dx);
    



