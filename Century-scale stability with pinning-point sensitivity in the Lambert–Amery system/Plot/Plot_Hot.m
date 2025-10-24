%%
clear clc;

% 定义文件路径
basePath1 = 'E:\MATLAB\WQX\Project2\2025_09_25_Output-Results';
% 定义文件名列表
fileNames = {
    'TM_VAF_GLF_GA_Ctrl1_Forward80.mat';
    'TM_VAF_GLF_GA_Ctrl2_Forward80.mat';
    'TM_VAF_GLF_GA_NORESM1_RCP85_Forward80.mat';
    'TM_VAF_GLF_GA_MIROC_RCP85_Forward80.mat';
    'TM_VAF_GLF_GA_IPSL-CM5A-MR_RCP85_Forward80.mat';
    'TM_VAF_GLF_GA_HadGEM2_RCP85_Forward80.mat';
    'TM_VAF_GLF_GA_CSIRO_RCP85_Forward80.mat';
    'TM_VAF_GLF_GA_CCSM4_RCP85_Forward80.mat';
    'TM_VAF_GLF_GA_UKESM1_CM6_SSP585_Forward80.mat';
    'TM_VAF_GLF_GA_CNRM-ESM2_SSP585_Forward80.mat';
    'TM_VAF_GLF_GA_CNRM-CM6_SSP585_Forward80.mat';
    'TM_VAF_GLF_GA_CESM2_SSP585_Forward80.mat'
};
% 定义 WithoutPinningPoint 文件名列表
withoutPinningPointFiles = {
    'TM_VAF_GLF_GA_Ctrl1_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_Ctrl2_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_NorESM1_RCP85_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_MIROC_RCP85_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_IPSL-CM5A-MR_RCP85_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_HadGEM2_RCP85_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_CSIRO_RCP85_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_CCSM4_RCP85_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_UKESM1_CM6_SSP585_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_CNRM-ESM2_SSP585_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_CNRM-CM6_SSP585_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_CESM2_SSP585_Forward80_PP500.mat'
};
% 加载数据
for i = 1:length(fileNames)
    fullpath = fullfile(basePath1, fileNames{i});
    varName = sprintf('Scenario%d', i-1);
    assignin('base', varName, load(fullpath));
end

% % 加载 WithoutPinningPoint 数据
% for i = 1:length(withoutPinningPointFiles)
%     fullpath = fullfile(basePath1, withoutPinningPointFiles{i}); % 假设文件在当前目录
%     varName = sprintf('Scenario%d', i-1); % Scenario20 到 Scenario31
%     assignin('base', varName, load(fullpath));
% end

%%
VAF0 = Scenario0.VAF_Gt-Scenario0.VAF_Gt(1);
VAF1 = Scenario1.VAF_Gt-Scenario1.VAF_Gt(1);
VAF2 = Scenario2.VAF_Gt-Scenario2.VAF_Gt(1);
VAF3 = Scenario3.VAF_Gt-Scenario3.VAF_Gt(1);
VAF4 = Scenario4.VAF_Gt-Scenario4.VAF_Gt(1);
VAF5 = Scenario5.VAF_Gt-Scenario5.VAF_Gt(1);
VAF6 = Scenario6.VAF_Gt-Scenario6.VAF_Gt(1);
VAF7 = Scenario7.VAF_Gt-Scenario7.VAF_Gt(1);
VAF8 = Scenario8.VAF_Gt-Scenario8.VAF_Gt(1);
VAF9 = Scenario9.VAF_Gt-Scenario9.VAF_Gt(1);
VAF10 = Scenario10.VAF_Gt-Scenario10.VAF_Gt(1);
VAF11 = Scenario11.VAF_Gt-Scenario11.VAF_Gt(1);

V1AF0=-VAF0(1:40:end);
V1AF1=-VAF1(1:40:end);
V1AF2=-VAF2(1:40:end);
V1AF3=-VAF3(1:40:end);
V1AF4=-VAF4(1:40:end);
V1AF5=-VAF5(1:40:end);
V1AF6=-VAF6(1:40:end);
V1AF7=-VAF7(1:40:end);
V1AF8=-VAF8(1:40:end);
V1AF9=-VAF9(1:40:end);
V1AF10=-VAF10(1:40:end);
V1AF11=-VAF11(1:40:end);

%%
% 将12个场景的数据合并为12x9矩阵
data = [V1AF0; 
        V1AF1;
        V1AF2;
        V1AF3;
        V1AF4;
        V1AF5;
        V1AF6;
        V1AF7;
        V1AF8;
        V1AF9;
        V1AF10;
        V1AF11];     % 12x9矩阵
% 创建坐标轴标签
years = 2020:10:2100; % 横轴年份
scenarios = {'Ctrl-Static','Ctrl-OceanAvg','NorESM1-rcp85','MIROC-rcp85','IPSL-CM5A-MR-rcp85','HadGEM2-rcp85',...
             'CSIRO-rcp85','CCSM4-rcp85','UKESM1-CM6-ssp585','CNRM-ESM2-ssp585','CNRM-CM6-ssp585','CESM2-ssp585'}; % 纵轴场景

% 数据归一化并去负零
processed_data = data / 361.8;
processed_data(abs(processed_data) < 1e-10) = 0; % 关键去负零步骤

% 绘制热力图
figure;
h = heatmap(years, scenarios, processed_data);

% 美化设置
h.Title = 'SLR for unperturbed geometry (mm)';
h.XLabel = 'Time (a)';
% h.YLabel = '场景';

% 计算对称色轴
maxabs = max(abs(processed_data(:)));

% 画热图
h.ColorLimits     = [-maxabs, maxabs];        % 让 0 居中
h.Colormap        = flipud(brewermap(256,'rdbu'));  % 你要的配色
h.ColorbarVisible = 'on';
h.FontSize = 15;
h.FontName = 'Times New Roman'; 
% 调整标签显示（若文字重叠）
h.XDisplayLabels = sprintfc('%d',years); % 确保年份显示为整数
set(gcf, 'Position', [500 200 930 750])  % 调整图像大小
h.CellLabelFormat = '%.2f';

drawnow;

print(gcf, 'E:\MATLAB\WQX\Project2\2025_09_25_Output-Results\Results\VAF-Hot2.png', '-dpng', '-r1000');

%%
MR0=Scenario0.total_melt_rate(1:40:end);
MR1=Scenario1.total_melt_rate(1:40:end);
MR2=Scenario2.total_melt_rate(1:40:end);
MR3=Scenario3.total_melt_rate(1:40:end);
MR4=Scenario4.total_melt_rate(1:40:end);
MR5=Scenario5.total_melt_rate(1:40:end);
MR6=Scenario6.total_melt_rate(1:40:end);
MR7=Scenario7.total_melt_rate(1:40:end);
MR8=Scenario8.total_melt_rate(1:40:end);
MR9=Scenario9.total_melt_rate(1:40:end);
MR10=Scenario10.total_melt_rate(1:40:end);
MR11=Scenario11.total_melt_rate(1:40:end);
% 将12个场景的数据合并为12x9矩阵
data = [MR0; 
        MR1;
        MR2;
        MR3;
        MR4;
        MR5;
        MR6;
        MR7;
        MR8;
        MR9;
        MR10;
        MR11];     % 12x9矩阵
% 创建坐标轴标签
years = 2020:10:2100; % 横轴年份
scenarios = {'Ctrl-Static','Ctrl-OceanAvg','NorESM1-rcp85','MIROC-rcp85','IPSL-CM5A-MR-rcp85','HadGEM2-rcp85',...
             'CSIRO-rcp85','CCSM4-rcp85','UKESM1-CM6-ssp585','CNRM-ESM2-ssp585','CNRM-CM6-ssp585','CESM2-ssp585'}; % 纵轴场景

% 绘制热力图
figure;
h = heatmap(years, scenarios, data);

% 美化设置
h.Title = 'Total basal melt rate of the AmIS (Gt a^{-1})';
h.XLabel = 'Time (a)';
% h.YLabel = '场景';
maxv = max(data(:));
h.ColorLimits = [0 maxv];                % 0 对应最浅色
h.Colormap    = brewermap(256,'Reds');   % 白→浅红→深红
h.ColorbarVisible = 'on';
h.FontSize = 15;
h.FontName = 'Times New Roman'; 
% 调整标签显示（若文字重叠）
h.XDisplayLabels = sprintfc('%d',years); % 确保年份显示为整数
set(gcf, 'Position', [500 200 930 750])  % 调整图像大小
h.CellLabelFormat = '%.2f';

drawnow;

print(gcf, 'E:\MATLAB\WQX\Project2\2025_09_25_Output-Results\Results\TM-Hot.png', '-dpng', '-r1000');