function Plm=Legendre_PL(maxDegree,nf,hdfai)
%%%给出求解区域的经纬度
Plm = zeros(maxDegree+1,maxDegree+1,nf);%设置一个三维数组，Plm用来存放勒让德函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=0:nf-1                                                                %纬圈循环，将j=0:nf-2调整为nf-1，避免了纬圈最后一列为0的现象
    for l=0:maxDegree
        for m=0:l
            %判断阶次，选择计算函数公式
            if (l==0)&&(m==0)                                               %第一个位置的值
                P(m+1,l+1)=1;                                               %此处的l+1表示存放在（0+1,0+1）位置，即第一行第一列（1,1）数组位置
            elseif (l==1)&&(m==0)                                           %算1阶0次的值
                P(m+1,l+1)=sqrt(3)*sin(hdfai(j+1));
            elseif (l==1)&&(m==1)                                           %算1阶1次的值
                P(m+1,l+1)=sqrt(3*(1-(sin(hdfai(j+1)))^2));
            elseif (l>=2)&&(m==l)                                           %算对角线的值
                P(m+1,l+1)=sqrt((2*l+1)/(2*l))*cos(hdfai(j+1))...
                    *P(l+1-1,l+1-1);                                        %此处的l+1-1表示定位（l+1）,再减一（-1）表示用公式中的前一项来推导。
            elseif (l>=2)&&(m==l-1)                                         %算紧贴对角线的值
                P(m+1,l+1)=sqrt(2*l+1)*sin(hdfai(j+1))*P(l+1-1,l+1-1);
            elseif (l>=2)&&(m<=l-2)                                         %算除了对角线和紧贴对角线以外的值
                P(m+1,l+1)=sqrt((4*l^2-1)/(l^2-m^2))*sin(hdfai(j+1))...
                    *P(m+1,l+1-1)-sqrt(((2*l+1)/(2*l-3))*(((l-1)^2-m^2))...
                    /(l^2-m^2))*P(m+1,l+1-2);                               %说明：此处注意提取P值的时候阶次顺序不可颠倒
            end
        end
    end
    Plm(:,:,j+1)= P;
end
Plm=permute(Plm,[2,1,3]);