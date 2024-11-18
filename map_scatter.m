%���ڻ�����������ͼ colorbar_valueΪ���ֵ colorbar_unitΪ��λ title_stringΪ����
% areaΪ���� һ��Ϊ��world'
function map_scatter(grid_vector,Lon,Lat,colorbar_value,colorbar_unit,title_string,area)
% Plot global grid using M_map toolbox 
% INPUT:
%   grid_data           Regular global gridded field (equi-angular grid N*2N)
%   colorbar_value      maximum value of colorbar
%   colorbar_unit       unit of colorbar ��λ
%   title_string        title above the figure
%   filename            output filename of figure
% OUTPUT:
% FENG Wei 12/02/2016
% State Key Laboratory of Geodesy and Earth's Dynamics
% Institute of Geodesy and Geophysics, Chinese Academy of Sciences
% fengwei@whigg.ac.cn
% gcf���ص�ǰFigure����ľ��ֵ gca���ص�ǰaxes����ľ��ֵ axes:����һ������ϵ
% axes(��position��,[0.1 0.2 0.3 0.4]); % ����һ������ϵ�� ����������ռ����ʾ����(figure)��ʮ��֮һ����
% �±�ռ��ʮ��֮��������ռʮ��֮������ռʮ��֮�ġ�
% ����������Ҫ�ڻ�ͼ֮ǰ

%% γ�Ⱥ;��ȣ�-180:1:180�� (90:-1:-90)
%% ����������Ϊ���������漸��
% [LON,LAT]=meshgrid(lon,lat);
% LON=reshape(LON,wei*jing,1);
% LAT=reshape(LAT,wei*jing,1);
% grid_vector=reshape(grid_vector,wei*jing,1);

%%ѡ��ͶӰ
m_proj('stereographic','lat',-90,'long',0,'radius',30);%��ƽͶӰ �Ƚ�
% m_proj('stereographic','lat',73,'long',-47,'radius',16,'rec','circle');%��ƽͶӰ �Ƚ�
% m_proj('Robinson','long',[min(Lon),max(Lon)],'lat',[min(Lat),max(Lat)]);
% m_proj('hammer','long',[min(Lon),max(Lon)],'lat',[min(Lat),max(Lat)]);
% m_proj('Equidistant Cylindrical','long',[min(Lon),max(Lon)],'lat',[min(Lat),max(Lat)]);%0:360,-90:90
% m_proj('Transverse Mercator','long',[min(Lon),max(Lon)],'lat',[min(Lat),max(Lat)]);%0:360,-90:90
%% ��ɫ
% m_pcolor(LON,LAT,grid_data);
if length(Lon)>10242 num=3;elseif length(Lon)<=10242 num=15;end
m_scatter(Lon,Lat,num,grid_vector,'o','filled');
shading interp;
% m_plotbndry('linewidth',1,'color','r')
% m_coast('linewidth',.5,'color','b');
% m_coast('patch',[0.7 0.8 0.7]);
% m_gshhs_i('color','k');       
hold on
map1(area);% ���߽���
% hold on
% load('coast.dat');
% plot(coast(:,1),coast(:,2),'linewidth',0.5,'color',[1 1 1]*0.5);
fontsize=12;
% m_grid('xtick',4,'ytick',4,'tickdir','in','xlabeldir','middle',...
%     'TickLength',0.008,'LineWidth',1.,'FontName', 'Helvetica','FontSize',fontsize-4,'fontweight','bold');%��γ�ȿ̶ȴ�С
m_grid('box','fancy','tickdir','in','xtick',4,'ytick',4,'linewidth',1,'TickLength',0.008,...
       'FontName', 'Helvetica','FontSize',fontsize-3,'fontweight','blod');                                     %����Χ�ĸ����������ô�ϸ������γ����ʾ���ô�С
% m_grid('box','on','tickdir','in','ytick',[-80 -70],'xtick',6,'FontSize',fontsize-4,'xaxislocation','top','linewi',0.5,'TickLength',0.02);%���������ϼ���
% xlabel('longtitude','FontName','Helvetica','FontSize',10,'fontweight','bold');
% ylabel('lattitude','FontName','Helvetica','FontSize',10,'fontweight','bold');
h=title(title_string,'fontsize',fontsize,'FontName', 'Helvetica','fontweight','bold');
% pos=get(h,'pos');set(h,'Units','data');pos(2)=0.29;set(h,'pos',pos);

caxis([-colorbar_value,colorbar_value]);
% caxis([0,colorbar_value]);
%����������λ��
% posf=get(gcf,'pos');posf(2)=posf(2)-20;posf(3)=1.3*posf(3);posf(4)=1.3*posf(4);set(gcf,'pos',posf);
% posa=get(gca,'pos');posa(1)=posa(1);posa(2)=2*posa(2);posa(3)=0.8*posa(3);posa(4)=0.8*posa(4);set(gca,'pos',posa);
%����colorbar���Ժ�λ��
colormap('jet')
h=colorbar('v','southoutside','FontSize',fontsize-2,'fontweight','bold','FontName', 'Helvetica');
% pos=get(h,'pos');pos(1)=pos(1);pos(2)=posa(2)-0.035;pos(3)=pos(3);pos(4)=0.7*pos(4);set(h,'pos',pos);
set(get(h,'title'),'string',colorbar_unit,'FontSize',fontsize-2);
%����colorbar����λ��
t=get(h,'title');pos=get(t,'pos');
pos(2)=-1.6*pos(2);set(t,'pos',pos);
% h=contourcmap('jet',-colorbar_value:0.5:colorbar_value,'colorbar','on','FontSize',15,'fontweight','bold');

% h_pos=get(h,'Position');%position [a b c d]ȷ, [a b]Ϊ��ͼ�������µ������.c,d�ֱ�Ϊ��ͼ����Ŀ�͸�.
% h_pos(1)=h_pos(1);
% h_pos(2)=h_pos(2);
% h_pos(3)=h_pos(3);
% h_pos(4)=h_pos(4);
% set(h,'Position',h_pos);

set(gcf, 'Color', 'white'); % white bckgr

end
