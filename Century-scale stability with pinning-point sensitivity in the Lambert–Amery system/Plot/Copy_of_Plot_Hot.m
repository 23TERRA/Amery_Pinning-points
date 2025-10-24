%%
clear clc;

% 定义文件路径
basePath1 = 'E:\MATLAB\WQX\Project2\2025_09_25_Output-Results';
% 定义文件名列表
fileNames = {
    'TM_VAF_GLF_GA_Ctrl1_Forward80.mat';
    'TM_VAF_GLF_GA_Ctrl1_Forward80_PP500.mat';
    'TM_VAF_GLF_GA_Ctrl1_Bjerki_Peninsula.mat';
    'TM_VAF_GLF_GA_Ctrl1_Budd_Ice_Rumples.mat';
    'TM_VAF_GLF_GA_Ctrl1_Clemece_Massif.mat';
    'TM_VAF_GLF_GA_Ctrl1_Dog_Island.mat';
    'TM_VAF_GLF_GA_Ctrl1_Foley_Promontory.mat';
    'TM_VAF_GLF_GA_Ctrl1_Gillock_Island.mat';
    'TM_VAF_GLF_GA_Ctrl1_Landon_Promontory.mat';
%     'TM_VAF_GLF_GA_Ctrl1_Podlednyj_Holm.mat';
    'TM_VAF_GLF_GA_Ctrl1_Robertson_Nunatak.mat';
    'TM_VAF_GLF_GA_Ctrl1_Single_Island.mat'; 
%     'TM_VAF_GLF_GA_Ctrl1_Svarthausen_Nunatak.mat';
    'TM_VAF_GLF_GA_Ctrl1_Tingey_Rocks.mat'
};

% 加载数据
for i = 1:length(fileNames)
    fullpath = fullfile(basePath1, fileNames{i});
    varName = sprintf('Scenario%d', i-1);
    assignin('base', varName, load(fullpath));
end


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
VAF12 = Scenario12.VAF_Gt-Scenario12.VAF_Gt(1);
VAF13 = Scenario13.VAF_Gt-Scenario13.VAF_Gt(1);

SLE_baseline=-VAF0(1:4:end) / 361.8;
SLE_All_PP=-VAF1(1:4:end) / 361.8;
SLE_Bjerki_Peninsula=-VAF2(1:4:end) / 361.8;
SLE_Budd_Ice_Rumples=-VAF3(1:4:end) / 361.8;
SLE_Clemence_Massif=-VAF4(1:4:end) / 361.8;
SLE_Dog_Island=-VAF5(1:4:end) / 361.8;
SLE_Foley_Promontory=-VAF6(1:4:end) / 361.8;
SLE_Gillock_Island=-VAF7(1:4:end) / 361.8;
SLE_Landon_Promontory=-VAF8(1:4:end) / 361.8;
SLE_Podlednyj_Holm=-VAF9(1:4:end) / 361.8;
SLE_Robertson_Nunatak=-VAF10(1:4:end) / 361.8;
SLE_Single_Island=-VAF11(1:4:end) / 361.8;
SLE_Svarthausen_Nunatak=-VAF12(1:4:end) / 361.8;
SLE_Tingey_Rocks=-VAF13(1:4:end) / 361.8;

dSLE_All_PP=SLE_All_PP-SLE_baseline;
dSLE_Bjerki_Peninsula=SLE_Bjerki_Peninsula-SLE_baseline;
dSLE_Budd_Ice_Rumples=SLE_Budd_Ice_Rumples-SLE_baseline;
dSLE_Clemence_Massif=SLE_Clemence_Massif-SLE_baseline;
dSLE_Dog_Island=SLE_Dog_Island-SLE_baseline;
dSLE_Foley_Promontory=SLE_Foley_Promontory-SLE_baseline;
dSLE_Gillock_Island=SLE_Gillock_Island-SLE_baseline;
dSLE_Landon_Promontory=SLE_Landon_Promontory-SLE_baseline;
dSLE_Podlednyj_Holm=SLE_Podlednyj_Holm-SLE_baseline;
dSLE_Robertson_Nunatak=SLE_Robertson_Nunatak-SLE_baseline;
dSLE_Single_Island=SLE_Single_Island-SLE_baseline;
dSLE_Svarthausen_Nunatak=SLE_Svarthausen_Nunatak-SLE_baseline;
dSLE_Tingey_Rocks=SLE_Tingey_Rocks-SLE_baseline;

save('E:\MATLAB\WQX\Project2\2025_09_25_Output-Results\Results\dSLE_PP.mat',"SLE_All_PP",'dSLE_Bjerki_Peninsula','dSLE_Budd_Ice_Rumples','dSLE_Clemence_Massif','dSLE_Dog_Island','dSLE_Foley_Promontory','dSLE_Gillock_Island','dSLE_Landon_Promontory','dSLE_Podlednyj_Holm','dSLE_Robertson_Nunatak','dSLE_Single_Island','dSLE_Svarthausen_Nunatak','dSLE_Tingey_Rocks')
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


V1AF1_diff=V1AF1-V1AF0;
V1AF2_diff=V1AF2-V1AF0;
V1AF3_diff=V1AF3-V1AF0;
V1AF4_diff=V1AF4-V1AF0;
V1AF5_diff=V1AF5-V1AF0;
V1AF6_diff=V1AF6-V1AF0;
V1AF7_diff=V1AF7-V1AF0;
V1AF8_diff=V1AF8-V1AF0;
V1AF9_diff=V1AF9-V1AF0;
V1AF10_diff=V1AF10-V1AF0;
V1AF11_diff=V1AF11-V1AF0;

data = [V1AF1_diff; 
        V1AF2_diff;
        V1AF3_diff;
        V1AF4_diff;
        V1AF5_diff;
        V1AF6_diff;
        V1AF7_diff;
        V1AF8_diff;
        V1AF9_diff;
        V1AF10_diff;
        V1AF11_diff];     % 12x9矩阵
% 创建坐标轴标签
years = 2020:10:2100; % 横轴年份
scenarios = {'All Pinning Points','Bjerki Peninsula','Budd Ice Rumples','Clemence Massif','Dog Island',...
             'Foley Promontory','Gillock Island','Landon Promontory','Robertson Nunatak','Single Island','Tingey Rocks'}; % 纵轴场景

% 数据归一化并去负零
processed_data = data / 361.8;
% processed_data(abs(processed_data) < 1e-10) = 0; % 关键去负零步骤

% 绘制热力图
figure;
h = heatmap(years, scenarios, processed_data);

% 隐藏 heatmap 自带标题
h.Title = '';

% 在图顶端居中放一个 LaTeX 文本框
annotation(gcf,'textbox',[0.03 0.93 1 0.06], ...   % [x y w h] 归一化坐标
  'String','$\Delta \mathrm{SLE}_i = \mathrm{SLE}_{\mathrm{pert},\; i} - \mathrm{SLE}_{\mathrm{Ctrl-Static}}\ \mathrm{(mm)}$', ...
  'Interpreter','latex','HorizontalAlignment','center','VerticalAlignment','middle', ...
  'LineStyle','none','FontSize',20);



% title('$\Delta \mathrm{SLE}_i = \mathrm{SLE}_{\mathrm{remove}\; i} - \mathrm{SLE}_{\mathrm{baseline}}\ \mathrm{(mm)}$', ...
%       'Interpreter','latex', 'FontSize',20);




h.XLabel = 'Time (a)';
% h.YLabel = '场景';

minv = min(processed_data(:));
maxv = max(processed_data(:));

if maxv<=0
    % 全非正：用蓝色系（和你原来一致）
    h.ColorLimits = [minv 0];
    h.Colormap    = flipud(brewermap(256,'Blues'));
else
    % 既有负也有正：用发散型（负蓝、正红，0 在中间）
    vmax = max(abs([minv maxv]));           % 对称到 0
    h.ColorLimits = [-vmax  vmax];
    h.Colormap    = flipud(brewermap(256,'RdBu'));  % Bu < 0, Rd > 0
end
h.ColorbarVisible = 'on';
h.FontSize = 15;

% 调整标签显示（若文字重叠）
h.XDisplayLabels = sprintfc('%d',years); % 确保年份显示为整数
set(gcf, 'Position', [500 200 930 750])  % 调整图像大小
h.CellLabelFormat = '%.2f';

drawnow;

print(gcf, 'E:\MATLAB\WQX\Project2\2025_09_25_Output-Results\BMB_VS\VAF-Hot-Ctrl1-VS.png', '-dpng', '-r1000');


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
scenarios = {'Ctrl-Static','All Pinning Points','Bjerki Peninsula','Budd Ice Rumples','Clemence Massif','Dog Island',...
             'Foley Promontory','Gillock Island','Landon Promontory','Robertson Nunatak','Single Island','Tingey Rocks'}; % 纵轴场景

% 绘制热力图
figure;
h = heatmap(years, scenarios, data);

% 美化设置
h.Title = 'Total basal melt rate of the AmIS (Gt a^{-1})';
h.XLabel = 'Time (a)';
% h.YLabel = '场景';
maxv = max(data(:));
h.ColorLimits = [0 maxv];                % 0 对应最浅色
h.Colormap        = flipud(brewermap(256,'rdbu'));  % 你要的配色
h.ColorbarVisible = 'on';
h.FontSize = 15;
h.FontName = 'Times New Roman'; 
% 调整标签显示（若文字重叠）
h.XDisplayLabels = sprintfc('%d',years); % 确保年份显示为整数
set(gcf, 'Position', [500 200 930 750])  % 调整图像大小
h.CellLabelFormat = '%.2f';

drawnow;

print(gcf, 'E:\MATLAB\WQX\Project2\2025_09_25_Output-Results\BMB_VS\PP-TM-Hot.png', '-dpng', '-r1000');