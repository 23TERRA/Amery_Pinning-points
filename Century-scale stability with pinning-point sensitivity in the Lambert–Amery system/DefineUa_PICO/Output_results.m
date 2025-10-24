clear clc;
path = 'D:\WQX\MATLAB\Relax20_Forward80_CCSM4\ResultsFiles';
VAF_Gt = zeros(1, 321);
fluxGL = zeros(1, 321);
GroundedArea = zeros(1, 321);
total_melt_rate = zeros(1, 321);
for j = 1:321
    X = fullfile(path, sprintf('%07d-Without_PinningPoint_TransientRun80.mat', (j-1)*25));
    data = load(X);
    [VAF,~,Int] = CalcVAF(data.CtrlVarInRestartFile, data.MUA, data.F.h, data.F.B, data.F.S, data.F.rho, data.F.rhow, data.GF);
    GroundedArea(j)= Int.Total;
    VAF_Gt(j) = VAF.Total*(10e-13*910);
    qGL1 = FluxAcrossGroundingLine(data.CtrlVarInRestartFile,data.MUA,data.GF,data.F.ub,data.F.vb,data.F.ud,data.F.vd,data.F.h,data.F.rho);
    fluxGL(j) = sum(qGL1)/10e+11;
    Int2=FEintegrate2D([],data.MUA,data.F.ab);
    total_melt_rate(j) = -sum(Int2)*10e-13*910;
    clear data VAF IceVolume Int qGL1 Int2
end
save('TM_VAF_GLF_GA_CCSM4_WithoutPinningPoint.mat','total_melt_rate','GroundedArea','VAF_Gt','fluxGL');

%%
path='D:\WQX\MATLAB\Relax20_Forward80_CESM2\ResultsFiles';
load(fullfile(path, '0008000-Without_PinningPoint_TransientRun80.mat'));

figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,F.B/1000);
hold on ;

[~,GLgeo,~,~]=IceSheetIceShelves(CtrlVarInRestartFile,MUA,GF);
[xGL,yGL]=ArrangeGroundingLinePos(CtrlVarInRestartFile,GLgeo);
plot(xGL/CtrlVarInRestartFile.PlotXYscale,yGL/CtrlVarInRestartFile.PlotXYscale,'r','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'k')
% title(sprintf('log_{10}(AGlen) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% title(colorbar,'log_{10}(yr^{-1} kPa^{-3})')

xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')
xlim([1672.1304186886 2249.56167457682]);
ylim([445.872800080901 1006.39663954361]);
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');

num_colors = 256; % 颜色数量
cmap = zeros(num_colors, 3);

% 定义渐变的三个阶段的颜色
blue_color = [237,125,49]/255;
white_color = [1, 1, 1];
red_color = [70, 192, 226]/255;

% 计算每个阶段的颜色数量
blue_to_white = round(num_colors / 2);
white_to_red = num_colors - blue_to_white;

for i = 1:num_colors
    if i <= blue_to_white
        % 在蓝色到白色之间渐变
        t = (i - 1) / (blue_to_white - 1);
        cmap(i, :) = (1 - t) * blue_color + t * white_color;
    else
        % 在白色到红色之间渐变
        t = (i - blue_to_white - 1) / (white_to_red - 1);
        cmap(i, :) = (1 - t) * white_color + t * red_color;
    end
end
colormap(cmap);
caxis([-3, 3]);
h = colorbar;
title(h, 'Bed Elevation (km)', 'FontSize', 15)
h.Ticks = [-3,-2.5, -2, -1.5,-1,-0.5,0,0.5,1,1.5,2,2.5, 3];
h.TickLabels = {'-3.0','-2.5', '-2.0', '-1.5', '-1.0','-0.5','0','0.5','1.0','1.5','2.0','2.5', '3.0'};
box on
% print(gcf, fullfile(path1, '地形图.png'), '-dpng', '-r1000');