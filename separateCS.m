function [cnm,snm]=separateCS(cs)
% separate spherical harmonic having format |c\s| 
% into C,S
if ndims(cs)==2
    snm=zeros(size(cs));
    [rows,~]=size(cs);
    cnm=tril(cs);
    for i=1:rows-1
        snm(i+1:end,i+1)=cs(i,i+1:end);
    end
end
if ndims(cs)==3
    [rows,colums,epochs]=size(cs);
    cnm=zeros(rows,colums,epochs);
    snm=zeros(rows,colums,epochs);
    for j=1:epochs
        csTemp(:,:)=cs(:,:,j);
        cnmTemp=tril(csTemp);
        snmTemp=zeros(rows,colums);
        for i=1:rows
            snm(i+1:end,i+1)=csTemp(i,i+1:end);
        end
        cnm(:,:,j)=cnmTemp;
        snm(:,:,j)=snmTemp;
    end
end

    
