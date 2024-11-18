clc;
close;
clear;

masconDirectory='D:\code\point mass\mascon';
masconFile=dir(fullfile(masconDirectory,"*.mat"));
load(fullfile(masconDirectory,masconFile(4).name));
lat=TWSA.latitude;
lon=TWSA.longitude;
EWH=TWSA.TWSA;
sita=TWSA.sita;
P=sita(1)./sita;
vData=EWH(:,1);
%% 数据可视化
clf;
m_proj('robinson','lon',[-179 179]);
m_scatter(lon,lat,10,vData,'o','filled');
m_grid('tickdir','out','linewi',2);
m_coast('linewidth',0.5,'color','k'); 
currentCMap=colormap('jet');
flippedCMap=flipud(currentCMap);
colormap(flippedCMap);
h=colorbar('northoutside');
set(h,'pos',get(h,'pos')+[.2 .05 -.4 0],'tickdir','out')
set(gcf,'color','w');
caxis([-20,20]);