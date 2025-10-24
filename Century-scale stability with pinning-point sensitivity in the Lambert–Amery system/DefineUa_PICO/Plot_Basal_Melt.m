%% 冰厚
path='D:\WQX\MATLAB\20250506\Relax20_Forward80_CCSM4\ResultsFiles';
X1=load(fullfile(path, '0000000-CCSM4_RCP85_Forward80.mat'));
%%
figure
set(gcf,'color','w','position',[500 200 1090 650]);
x=X1.MUA.coordinates(:,1);  y=X1.MUA.coordinates(:,2);

% AmIS_meltRates=MeltRate(x,y);
% AmIS_meltRates_uncert=MeltRate_uncert(x,y);
% nonEmptyValues = AmIS_meltRates(~isnan(AmIS_meltRates));
% meanValue = mean(nonEmptyValues);
PlotMeshScalarVariable(X1.CtrlVarInRestartFile,X1.MUA,-X1.F.ab);
AmIS=-mean(X1.F.ab.*(1-X1.GF.node));
hold on ;
[~,GLgeo,~,~]=IceSheetIceShelves(X1.CtrlVarInRestartFile,X1.MUA,X1.GF);
[xGL,yGL]=ArrangeGroundingLinePos(X1.CtrlVarInRestartFile,GLgeo);
plot(xGL/X1.CtrlVarInRestartFile.PlotXYscale,yGL/X1.CtrlVarInRestartFile.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(X1.CtrlVarInRestartFile,X1.MUA,'k')

xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')
% xlim([1568 2274]);
% ylim([550 900]);
xlim([1658 2253])
ylim([600 850]);
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');


colormap(flipud(brewermap([],'rdbu')));
clim([-20, 20]);
h = colorbar;
title(h, 'Basal melt rate (m a^{-1})', 'FontSize', 15)
title(sprintf('2020 CCSM4-rcp85'),'FontSize',20,'fontname','time news roman');
% h.Ticks = [-3,-2.5, -2, -1.5,-1,-0.5,0,0.5,1,1.5,2,2.5, 3];
% h.TickLabels = {'-3.0','-2.5', '-2.0', '-1.5', '-1.0','-0.5','0','0.5','1.0','1.5','2.0','2.5', '3.0'};
box on
% print(gcf, 'E:\王千禧材料\EGU\Poster\HadGEM-2020BMB.png', '-dpng', '-r1000');
%%
data = load(fullfile(path, '0000000-CCSM4_RCP85_Forward80.mat'));
[VAF,~,Int] = CalcVAF(data.CtrlVarInRestartFile, data.MUA, data.F.h, data.F.B, data.F.S, data.F.rho, data.F.rhow, data.GF);
GroundedArea= Int.Total;
VAF_Gt = VAF.Total*(10e-13*910);
qGL1 = FluxAcrossGroundingLine(data.CtrlVarInRestartFile,data.MUA,data.GF,data.F.ub,data.F.vb,data.F.ud,data.F.vd,data.F.h,data.F.rho);
fluxGL = sum(qGL1)/10e+11;
Int2=FEintegrate2D([],data.MUA,data.F.ab);
total_melt_rate = -sum(Int2)*10e-13*910;