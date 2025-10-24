% ---- 输入：10 个情景的整架总底融量（Gt a^-1） ----
names = {'NorESM1-rcp85','MIROC-rcp85','IPSL-CM5A-MR-rcp85','HadGEM2-rcp85', ...
         'CSIRO-rcp85','CCSM4-rcp85','UKESM1-CM6-ssp585','CNRM-ESM2-ssp585', ...
         'CNRM-CM6-ssp585','CESM2-ssp585'};
M = [27.2486879460748 15.0703236969617 41.5020440672344 24.5717732456369 18.7049046678293 15.2250616932645 14.9947025228558 16.1232530982049 24.3369885357393 15.0894743444381];   % 示例

% （可选）观测总量及不确定度，用灰带标出来
obs_mean = 45.6;   % 例子：Adusumilli 的整架总底融（Gt a^-1）
obs_sigma = 40.0;  % 例子：±1σ（若只有整体不确定度）

% ---- 统计：MMM 与 5/95 百分位 ----
mmm = mean(M);
p5  = prctile(M,5);
p95 = prctile(M,95);

% ---- 作图：10 个情景的细色条 + 右侧 MMM 黑点±须 + 观测灰带 ----
figure
set(gcf,'color','w','position',[500 200 750 650]);
hold on

% 观测灰带（先画，置底）
x_left  = 0.5; 
x_right = numel(M)+1.5;   % 右侧留出 1 个位置给 MMM
patch([x_left x_right x_right x_left], ...
      [obs_mean-obs_sigma obs_mean-obs_sigma obs_mean+obs_sigma obs_mean+obs_sigma], ...
      [0.85 0.85 0.85], 'EdgeColor','none', 'FaceAlpha',0.35);

% 情景条形图
x = 1:numel(M);
bar(x, M, 0.7, 'FaceColor',[0.78 0.85 0.95], 'EdgeColor',[0.3 0.3 0.3]);

% MMM 黑点 ± 5–95% 误差线（画在最右侧）
x0 = numel(M)+1;   % MMM 的 x 位置
errorbar(x0, mmm, mmm-p5, p95-mmm, 'k', ...              %向下/向上的误差长度
         'LineWidth',1.6, 'CapSize',10);                 % 竖直误差线
plot(x0, mmm, 'ko', 'MarkerFaceColor','k', 'MarkerSize',6);

% 轴与刻度
xlim([0.5, x_right]);
ylim([0, 90]);
ylabel('2020 AmIS basal melt (Gt a^{-1})', ...
       'FontName','Times New Roman','FontSize',15);
xticks([x x0]);
xticklabels([names, {'Ensemble mean (P5–P95)'}]);
xtickangle(35); grid on; box on
set(gca,'FontName','Times New Roman','FontSize',15);

% 可选：在图内标注 MMM 数字
text(x0+0.1, mmm, sprintf(' %.1f', mmm), 'VerticalAlignment','middle', ...
     'FontName','Times New Roman','FontSize',15);

% —— 在作完图之后加 ——
% 抬高 y 轴上限，给文字留空间
ymax = max([M, obs_mean+obs_sigma])*1.15;
ylim([0, ymax]);
ylim([0, 90]);
% 要显示的三项（注意单位）
r_val    = 0.755;
Bias_val = -0.687;   % m a^-1
RMSE_val =  2.185;   % m a^-1

% 文字内容（多行）
% txt = { 'Spatial metrics vs. Adusumilli (2020):', ...
%         sprintf('r = %.3f', r_val), ...
%         sprintf('Bias = %.3f m a^{-1}', Bias_val), ...
%         sprintf('RMSE = %.3f m a^{-1}', RMSE_val)};
txt = { 'Spatial metrics vs. Adusumilli et al.(2020):', ... 
    sprintf('                          r = %.3f', r_val)};

% 放在右上角
xpos = numel(M)-6;           % 接近 MMM 位置的右侧
ypos = ymax*0.83;              % 轴的 92% 高度
text(xpos, ypos, txt, ...
    'FontName','Times New Roman','FontSize',15, ...
    'HorizontalAlignment','left','VerticalAlignment','top', ...
    'BackgroundColor','w','Margin',5,'EdgeColor',[0.6 0.6 0.6]);

% print(gcf, 'M-VS-O.png', '-dpng', '-r1000');
