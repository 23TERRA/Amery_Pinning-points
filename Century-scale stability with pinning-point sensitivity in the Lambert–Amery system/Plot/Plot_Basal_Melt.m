%% 冰厚
path='E:\MATLAB\WQX\Project2\20250506秦青PICO\New_Outputs';
X1=load(fullfile(path, '0000000-HadGEM2_RCP85_Forward80.mat'));
load('Basal_Melt_Rate.mat');
load('Avg_BM.mat');
%%
figure
set(gcf,'color','w','position',[500 200 1090 650]);
x=X1.MUA.coordinates(:,1);  y=X1.MUA.coordinates(:,2);

AmIS_meltRates=MeltRate(x,y);
PlotMeshScalarVariable(X1.CtrlVarInRestartFile,X1.MUA,AmIS_meltRates);
hold on ;
[~,GLgeo,~,~]=IceSheetIceShelves(X1.CtrlVarInRestartFile,X1.MUA,X1.GF);
[xGL,yGL]=ArrangeGroundingLinePos(X1.CtrlVarInRestartFile,GLgeo);
plot(xGL/X1.CtrlVarInRestartFile.PlotXYscale,yGL/X1.CtrlVarInRestartFile.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(X1.CtrlVarInRestartFile,X1.MUA,'k')

xlabel('xps (km)','FontSize', 15,'fontname','Times New Roman')
ylabel('yps (km)','FontSize', 15,'fontname','Times New Roman')
% xlim([1568 2274]);
% ylim([550 900]);
xlim([1658 2253])
ylim([600 850]);
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','Times New Roman');


colormap(flipud(brewermap([],'rdbu')));
clim([-20, 20]);
h = colorbar;
title(h, 'Basal melt rate (m a^{-1})', 'FontSize', 15)
% title(sprintf('2020 HadGEM2-RCP85'),'FontSize',20,'fontname','time news roman');
title(sprintf('Adusumilli et al., 2020'),'FontSize',20,'fontname','Times New Roman');
% h.Ticks = [-3,-2.5, -2, -1.5,-1,-0.5,0,0.5,1,1.5,2,2.5, 3];
% h.TickLabels = {'-3.0','-2.5', '-2.0', '-1.5', '-1.0','-0.5','0','0.5','1.0','1.5','2.0','2.5', '3.0'};
box on
print(gcf, '观测.png', '-dpng', '-r1000');
%%
figure
set(gcf,'color','w','position',[500 200 1090 650]);
x=X1.MUA.coordinates(:,1);  y=X1.MUA.coordinates(:,2);
Mi(X1.GF.node==1)=nan;
PlotMeshScalarVariable(X1.CtrlVarInRestartFile,X1.MUA,Mi);
hold on ;
[~,GLgeo,~,~]=IceSheetIceShelves(X1.CtrlVarInRestartFile,X1.MUA,X1.GF);
[xGL,yGL]=ArrangeGroundingLinePos(X1.CtrlVarInRestartFile,GLgeo);
plot(xGL/X1.CtrlVarInRestartFile.PlotXYscale,yGL/X1.CtrlVarInRestartFile.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(X1.CtrlVarInRestartFile,X1.MUA,'k')

xlabel('xps (km)','FontSize', 15,'fontname','Times New Roman')
ylabel('yps (km)','FontSize', 15,'fontname','Times New Roman')
% xlim([1568 2274]);
% ylim([550 900]);
xlim([1658 2253])
ylim([600 850]);
set(gca, 'FontSize', 15,'fontname','Times New Roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','Times New Roman');


colormap(flipud(brewermap([],'rdbu')));
clim([-20, 20]);
h = colorbar;
title(h, 'Basal melt rate (m a^{-1})', 'FontSize', 15)
% title(sprintf('2020 HadGEM2-RCP85'),'FontSize',20,'fontname','time news roman');
title(sprintf('Ensemble-mean basal melt rate, 2020'),'FontSize',20,'fontname','Times New Roman');
% h.Ticks = [-3,-2.5, -2, -1.5,-1,-0.5,0,0.5,1,1.5,2,2.5, 3];
% h.TickLabels = {'-3.0','-2.5', '-2.0', '-1.5', '-1.0','-0.5','0','0.5','1.0','1.5','2.0','2.5', '3.0'};
box on
print(gcf, '多模型平均.png', '-dpng', '-r1000');
