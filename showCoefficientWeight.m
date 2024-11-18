function showCoefficientWeight(normalizedWeight,modelNames)
averageWeight=squeeze(mean(normalizedWeight,3));
[ndegree,norder,~,nmodel]=size(normalizedWeight);
[xx,yy]=meshgrid(1:2*norder-1,1:ndegree);
% 设置子图布局
rows=ceil(nmodel/4);
colums=4;
for i=1:nmodel
    subplot(rows,colums,i);
    mapData=averageWeight(:,:,i);
    mapData=cs2sc(mapData);
    mapData(mapData==0)=NaN;
    surface(xx,yy,mapData,'EdgeColor','none');
    % 将Y轴倒转
    set(gca,'YDir','reverse');
    % 设置颜色棒
    colormap("jet");
    caxis([0,0.3]);
    cb=colorbar('h');
    cb.Ticks=[0,0.1,0.2,0.3];
    cb.TickLabels={'0';'0.1';'0.2';'0.3'};
    % 设置标题
    title(modelNames{i});
end
