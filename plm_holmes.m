function Plm=plm_holmes(maxDegree,x)
x=squeeze(x);
nf=length(x);
x=reshape(x,[1,1,nf]);
u=sqrt(1-x.^2);
%%%给出求解区域的经纬度
Plm = zeros(maxDegree+1,maxDegree+1,nf);%设置一个三维数组，Plm用来存放勒让德函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for l=0:maxDegree
        for m=0:l
            %判断阶次，选择计算函数公式
            if (l==0)&&(m==0)
                %第一个位置的值
                %此处的l+1表示存放在（0+1,0+1）位置，即第一行第一列（1,1）数组位置
                Plm(m+1,l+1,:)=1;
            elseif (l==1)&&(m==0)
                %算1阶0次的值
                Plm(m+1,l+1,:)=sqrt(3).*x;
            elseif (l==1)&&(m==1) 
                %算1阶1次的值
                Plm(m+1,l+1,:)=sqrt(3).*u;
            elseif (l>=2)&&(m==l)
                %算对角线的值
                P0=Plm(l+1-1,l+1-1,:);
                Plm(m+1,l+1,:)=sqrt((2*l+1)/(2*l)).*u.*P0;
                %此处的l+1-1表示定位（l+1）,再减一（-1）表示用公式中的前一项来推导。
            elseif (l>=2)&&(m==l-1)
                %算紧贴对角线的值
                P1=Plm(l+1-1,l+1-1,:);
                Plm(m+1,l+1,:)=sqrt(2*l+1).*x.*P1;
            elseif (l>=2)&&(m<=l-2)
                %算除了对角线和紧贴对角线以外的值
                P2=Plm(m+1,l+1-1,:);
                P3=Plm(m+1,l+1-2,:);
                c1=sqrt((4*l^2-1)/(l^2-m^2));
                c2=sqrt((2*l+1)/(2*l-3)*((l-1)^2-m^2)/(l^2-m^2));
                Plm(m+1,l+1,:)=c1*x.*P2-c2*P3;
                %说明：此处注意提取P值的时候阶次顺序不可颠倒
            end
        end
end
Plm=permute(Plm,[2,1,3]);
