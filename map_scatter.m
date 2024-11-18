%用于绘制向量格网图 colorbar_value为最大值 colorbar_unit为单位 title_string为标题
% area为区域 一般为‘world'
function map_scatter(grid_vector,Lon,Lat,colorbar_value,colorbar_unit,title_string,area)
% Plot global grid using M_map toolbox 
% INPUT:
%   grid_data           Regular global gridded field (equi-angular grid N*2N)
%   colorbar_value      maximum value of colorbar
%   colorbar_unit       unit of colorbar 单位
%   title_string        title above the figure
%   filename            output filename of figure
% OUTPUT:
% FENG Wei 12/02/2016
% State Key Laboratory of Geodesy and Earth's Dynamics
% Institute of Geodesy and Geophysics, Chinese Academy of Sciences
% fengwei@whigg.ac.cn
% gcf返回当前Figure对象的句柄值 gca返回当前axes对象的句柄值 axes:创建一个坐标系
% axes(‘position’,[0.1 0.2 0.3 0.4]); % 创建一个坐标系。 让起点是左边占到显示窗口(figure)的十分之一处，
% 下边占到十分之二处。宽占十分之三，高占十分之四。
% 建立坐标轴要在绘图之前

%% 纬度和经度（-180:1:180） (90:-1:-90)
%% 如果输入格网为矩阵用下面几行
% [LON,LAT]=meshgrid(lon,lat);
% LON=reshape(LON,wei*jing,1);
% LAT=reshape(LAT,wei*jing,1);
% grid_vector=reshape(grid_vector,wei*jing,1);

%%选择投影
m_proj('stereographic','lat',-90,'long',0,'radius',30);%赤平投影 等角
% m_proj('stereographic','lat',73,'long',-47,'radius',16,'rec','circle');%赤平投影 等角
% m_proj('Robinson','long',[min(Lon),max(Lon)],'lat',[min(Lat),max(Lat)]);
% m_proj('hammer','long',[min(Lon),max(Lon)],'lat',[min(Lat),max(Lat)]);
% m_proj('Equidistant Cylindrical','long',[min(Lon),max(Lon)],'lat',[min(Lat),max(Lat)]);%0:360,-90:90
% m_proj('Transverse Mercator','long',[min(Lon),max(Lon)],'lat',[min(Lat),max(Lat)]);%0:360,-90:90
%% 着色
% m_pcolor(LON,LAT,grid_data);
if length(Lon)>10242 num=3;elseif length(Lon)<=10242 num=15;end
m_scatter(Lon,Lat,num,grid_vector,'o','filled');
shading interp;
% m_plotbndry('linewidth',1,'color','r')
% m_coast('linewidth',.5,'color','b');
% m_coast('patch',[0.7 0.8 0.7]);
% m_gshhs_i('color','k');       
hold on
map1(area);% 画边界线
% hold on
% load('coast.dat');
% plot(coast(:,1),coast(:,2),'linewidth',0.5,'color',[1 1 1]*0.5);
fontsize=12;
% m_grid('xtick',4,'ytick',4,'tickdir','in','xlabeldir','middle',...
%     'TickLength',0.008,'LineWidth',1.,'FontName', 'Helvetica','FontSize',fontsize-4,'fontweight','bold');%经纬度刻度大小
m_grid('box','fancy','tickdir','in','xtick',4,'ytick',4,'linewidth',1,'TickLength',0.008,...
       'FontName', 'Helvetica','FontSize',fontsize-3,'fontweight','blod');                                     %加周围的格网，并设置粗细，给经纬度显示设置大小
% m_grid('box','on','tickdir','in','ytick',[-80 -70],'xtick',6,'FontSize',fontsize-4,'xaxislocation','top','linewi',0.5,'TickLength',0.02);%格网属性南极用
% xlabel('longtitude','FontName','Helvetica','FontSize',10,'fontweight','bold');
% ylabel('lattitude','FontName','Helvetica','FontSize',10,'fontweight','bold');
h=title(title_string,'fontsize',fontsize,'FontName', 'Helvetica','fontweight','bold');
% pos=get(h,'pos');set(h,'Units','data');pos(2)=0.29;set(h,'pos',pos);

caxis([-colorbar_value,colorbar_value]);
% caxis([0,colorbar_value]);
%设置坐标轴位置
% posf=get(gcf,'pos');posf(2)=posf(2)-20;posf(3)=1.3*posf(3);posf(4)=1.3*posf(4);set(gcf,'pos',posf);
% posa=get(gca,'pos');posa(1)=posa(1);posa(2)=2*posa(2);posa(3)=0.8*posa(3);posa(4)=0.8*posa(4);set(gca,'pos',posa);
%设置colorbar属性和位置
colormap('jet')
h=colorbar('v','southoutside','FontSize',fontsize-2,'fontweight','bold','FontName', 'Helvetica');
% pos=get(h,'pos');pos(1)=pos(1);pos(2)=posa(2)-0.035;pos(3)=pos(3);pos(4)=0.7*pos(4);set(h,'pos',pos);
set(get(h,'title'),'string',colorbar_unit,'FontSize',fontsize-2);
%设置colorbar标题位置
t=get(h,'title');pos=get(t,'pos');
pos(2)=-1.6*pos(2);set(t,'pos',pos);
% h=contourcmap('jet',-colorbar_value:0.5:colorbar_value,'colorbar','on','FontSize',15,'fontweight','bold');

% h_pos=get(h,'Position');%position [a b c d]确, [a b]为绘图区域左下点的坐标.c,d分别为绘图区域的宽和高.
% h_pos(1)=h_pos(1);
% h_pos(2)=h_pos(2);
% h_pos(3)=h_pos(3);
% h_pos(4)=h_pos(4);
% set(h,'Position',h_pos);

set(gcf, 'Color', 'white'); % white bckgr

end
