%% ==== 1) 组织数据：每个 pinning 一个条目（示例填三条，按你的数据补齐） ====
% years   : 2020:1:2100
% dSLE    : 该 pinning 的 ΔSLE_i(t) [mm]
% dAg     : 该 pinning 的 ΔA_g,i(t) = A_pert - A_base  [km^2]  (环带内)
clear clc;
P = struct('name',{},'years',{},'dSLE',{},'dAg',{});

load("dAg.mat");
load("A_base_Ag.mat");
load("A_pert_Ag.mat");
load("dSLE_PP.mat");
years =1:1:81;
% --- 举例（请替换为你真实的向量） ---
P(1).name  = 'All Pinning Points';P(1).A_base = A_base_All_PP; P(1).A_pert = A_pert_All_PP;
P(1).years = years;               P(1).dSLE = dSLE_All_PP;   P(1).dAg = dAg_All_PP;
P(2).name  = 'Bjerki Peninsula';  P(2).A_base = A_base_Bjerki_Peninsula; P(2).A_pert = A_pert_Bjerki_Peninsula;
P(2).years = years;               P(2).dSLE = dSLE_Bjerki_Peninsula;   P(2).dAg = dAg_Bjerki_Peninsula;
P(3).name  = 'Budd Ice Rumples';  P(3).A_base = A_base_Budd_Ice_Rumples; P(3).A_pert = A_pert_Budd_Ice_Rumples;
P(3).years = years;               P(3).dSLE = dSLE_Budd_Ice_Rumples;     P(3).dAg = dAg_Budd_Ice_Rumples;
P(4).name  = 'Clemence Massif';   P(4).A_base = A_base_Clemence_Massif; P(4).A_pert = A_pert_Clemence_Massif;
P(4).years = years;               P(4).dSLE = dSLE_Clemence_Massif;   P(4).dAg = dAg_Clemence_Massif;
P(5).name  = 'Dog Island';        P(5).A_base = A_base_Dog_Island; P(5).A_pert = A_pert_Dog_Island;
P(5).years = years;               P(5).dSLE = dSLE_Dog_Island;   P(5).dAg = dAg_Dog_Island;
P(6).name  = 'Foley Promontory';  P(6).A_base = A_base_Foley_Promontory; P(6).A_pert = A_pert_Foley_Promontory;
P(6).years = years;               P(6).dSLE = dSLE_Foley_Promontory;     P(6).dAg = dAg_Foley_Promontory;
P(7).name  = 'Gillock Island';    P(7).A_base = A_base_Gillock_Island; P(7).A_pert = A_pert_Gillock_Island;
P(7).years = years;               P(7).dSLE = dSLE_Gillock_Island;   P(7).dAg = dAg_Gillock_Island;
P(8).name  = 'Landon Promontory'; P(8).A_base = A_base_Landon_Promontory; P(8).A_pert = A_pert_Landon_Promontory;
P(8).years = years;               P(8).dSLE = dSLE_Landon_Promontory;   P(8).dAg = dAg_Landon_Promontory;
P(9).name  = 'Podlednyj Holm';    P(9).A_base = A_base_Podlednyj_Holm; P(9).A_pert = A_pert_Podlednyj_Holm;
P(9).years = years;               P(9).dSLE = dSLE_Podlednyj_Holm;     P(9).dAg = dAg_Podlednyj_Holm;
P(10).name  = 'Robertson Nunatak'; P(10).A_base = A_base_Robertson_Nunatak; P(10).A_pert = A_pert_Robertson_Nunatak;
P(10).years = years;               P(10).dSLE = dSLE_Robertson_Nunatak;   P(10).dAg = dAg_Robertson_Nunatak;
P(11).name  = 'Single Island';     P(11).A_base = A_base_Single_Island; P(11).A_pert = A_pert_Single_Island;
P(11).years = years;               P(11).dSLE = dSLE_Single_Island;   P(11).dAg = dAg_Single_Island;
P(12).name  = 'Svarthausen Nunatak';P(12).A_base = A_base_Svarthausen_Nunatak; P(12).A_pert = A_pert_Svarthausen_Nunatak;
P(12).years = years;                P(12).dSLE = dSLE_Svarthausen_Nunatak;     P(12).dAg = dAg_Svarthausen_Nunatak;
P(13).name  = 'Tingey Rocks';       P(13).A_base = A_base_Tingey_Rocks; P(13).A_pert = A_pert_Tingey_Rocks;
P(13).years = years;                P(13).dSLE = dSLE_Tingey_Rocks;     P(13).dAg = dAg_Tingey_Rocks;

%% ==== 2) 计算指标 ====
for k = 1:numel(P)
    yy = P(k).years(:);
    ds = P(k).dSLE(:);                % mm
    da = P(k).dAg(:);                 % km^2  (负=接地减少/未接地)
    Ab = P(k).A_base(:);
    Ap = P(k).A_pert(:);
    % 2.1 晚世纪均值 S_i^late （2080–2100）
    win = (yy>=61 & yy<=81);
    XXX=61;
    win1 = (yy==XXX);
    P(k).S_late = mean(ds(win1),'omitnan');        % mm
    P(k).S_late1 = mean(ds(win),'omitnan'); 
    % 2.2 最大接地损失 |min ΔAg|
    % P(k).Ag_loss = abs(min(da,[],'omitnan'));      % 10^3 km^2? ——按你的单位，若需要/1e3
    P(k).Ag_loss = abs(da(XXX));
    % 2.3 再接地比例 R_late
    R = Ap ./ max(Ab, 1e-6);    % 防 0 除，限制在[0,1]
    R = max(0,min(1,R));
    P(k).R_late = mean(R(win),'omitnan');


    % 2.4 t50%：达到 0.5*S_late 的最早年份（用3年滑动均值更稳）
    target = 0.5*P(k).S_late1;
    ds_s = movmean(ds,3,'Endpoints','shrink');
    idx = find(ds_s>=target,1,'first');
    if ~isempty(idx)
        P(k).t50 = yy(idx);
    else
        P(k).t50 = NaN;  % 未达到
    end
end


%% ==== 抽向量 ====
names   = string({P.name});
Y       = [P.S_late];          % y: 晚世纪 ΔSLE 平均 (mm)
Rlate   = [P.R_late];          % 点大小：再接地比例 [0,1]
t50     = [P.t50];             % 颜色：t50（年份索引 1..81）

% 把 t50 换成真正的“年份”，未达到目标的记为 2100（同色）
t50_year        = 2019 + t50;                  % 1->2020, …, 81->2100
t50_year(isnan(t50_year)) = 2100;

%% ==== 点大小：R_late -> 面积 ====
smin = 36;           % 最小点面积（pt^2，约直径 6pt）
smax = 256;          % 最大点面积（pt^2，约直径 16pt）
alphaR = 1.3;        % 映射幂次：>1 更凸显大的 R_late
Rclip = min(max(Rlate,0),1);
Ssz  = (smin + (smax - smin) .* (Rclip.^alphaR))*10;

%% ==== 颜色：t50 年份 ====
C = t50_year;                     % 颜色就是年份
cmin = 2020;  cmax = 2100;        % 颜色条范围

%% ==== 绘图 ====
figure; set(gcf,'Color','w','Position',[500 200 780 600]); hold on;
sc = scatter([P.Ag_loss], Y, Ssz, C, 'filled', ...
             'MarkerEdgeColor',[0.2 0.2 0.2]);
sc.MarkerFaceAlpha = 1; sc.MarkerEdgeAlpha = 1;

colormap(turbo);
cb = colorbar;
caxis([cmin cmax]);
cb.Label.Interpreter = 'latex';
cb.Label.String = '$t_{50\%}\ \mathrm{(a)}$';
cb.FontName = 'Times New Roman'; cb.FontSize = 15;

% 轴：x=最大接地损失 对数坐标；y=ΔSLE 
set(gca,'XScale','log');                % 对数轴
% xlabel('$|\min\,\Delta A_{\mathrm{g},\,i}| \ (\mathrm{km}^2) \,\mathrm{(log scale)}$', ...
%        'Interpreter','latex','FontName','Times New Roman','FontSize',15);
% ylabel('$\overline{\Delta \mathrm{SLE}_i}^{2080\mbox{--}2100}$ (mm)', ...
%        'Interpreter','latex','FontName','Times New Roman','FontSize',15);

% % X: 最大接地面积损失（对数轴）
% xlabel('Maximum grounding-area loss (km$^2$, log scale)', ...
%        'Interpreter','latex','FontName','Times New Roman','FontSize',15);
% 
% % Y: 海平面贡献量
% ylabel('SLE (mm)', ...
%        'Interpreter','latex','FontName','Times New Roman','FontSize',15);
% X: 最大接地面积损失（扰动–对照）
xlabel('Grounding-area loss at 2100 (perturbed--control; km$^2$, log)', ...
       'Interpreter','latex','FontName','Times New Roman','FontSize',15);

ylabel('$\Delta \mathrm{SLR}_{2100}$ (perturbed--control; mm)', ...
       'Interpreter','latex','FontName','Times New Roman','FontSize',15);

grid on; box on;
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
ylim([-0.1,0.9]);

%% ---- 参考线：连接“原点–All Pinning Points” ----
kref  = find(strcmp(string({P.name}),'All Pinning Points'), 1, 'first');
Xref  = P(kref).Ag_loss;       % 参考点的 x（|min ΔAg|）
Yref  = P(kref).S_late;        % 参考点的 y（S_late）

m = Yref / Xref;               % 斜率

% 2) 在当前对数 x 轴范围内取一组 x 点，画 y = m*x
xl   = xlim;                   % 当前坐标范围
xg   = logspace(log10(xl(1)), log10(xl(2)), 200);   % 适合 log-x 的采样
yg   = m .* xg;

% 可选：把超出 y 轴范围的部分截断以免挡图
yl   = ylim;
yg(yg>yl(2)) = NaN;

% 3) 画线 + 标注
href = plot(xg, yg, 'k--', 'LineWidth', 1.2);
plot(Xref, Yref, '*', 'MarkerFaceColor','w', 'MarkerSize', 6);  % 标出 APP 点

txtHL = '$y=\frac{y_{\mathrm{APPs}}}{x_{\mathrm{APPs}}}\,x$';
text(0.66,0.95, txtHL, 'Units','normalized', ...
     'Interpreter','latex', ...                 % 关键：启用 LaTeX
     'FontName','Times New Roman','FontSize',15, ...
     'Color',[0.35 0.35 0.35]);

%%
%% ==== Bubble-size scale for R_late (top-left inset) ====
% Use the same mapping from R_late to SizeData as in the main scatter:
size_from_R = @(r) (smin + (smax - smin).*(min(max(r,0),1).^alphaR))*10;

% Choose a few representative ticks for the scale:
R_ticks = [0.0, 0.5, 1.0];              % shown values of R_late
S_ticks = size_from_R(R_ticks);         % corresponding marker areas (pt^2)

% Create a small inset axes in the upper-left of the main axes:
ax = gca;
pos = ax.Position;                       % [left bottom width height] in normalized figure units
w   = 0.22;  h = 0.22;                   % size of the inset (tune if needed)
inset = axes('Position',[pos(1)+0.05, pos(2)+pos(4)-h-0.06, w, h]);
hold(inset,'on'); axis(inset,'off'); xlim(inset,[0 1]); ylim(inset,[0 1]);

% Title (academic English, LaTeX):

% text(inset, 0, 0.98, ...
%     '$\overline{R_{\mathrm{re-g}}}^{2080-2100}$', ...
%     'Interpreter','latex','FontName','Times New Roman','FontSize',12,'VerticalAlignment','top');


% Plot the three reference bubbles:
ypos = linspace(0,0.98,numel(R_ticks));
scatter(inset, 0, ypos, S_ticks, [0.7 0.7 0.7], 'filled', ...
        'MarkerEdgeColor',[0.2 0.2 0.2]);   % neutral grey so color doesn’t imply meaning

% Labels to the right of each bubble:
for i = 1:numel(R_ticks)
    lbl = sprintf('$R_{\\mathrm{late}}=%.1f$', R_ticks(i));
    text(inset, 0.25, ypos(i), lbl, ...
        'Interpreter','latex','FontName','Times New Roman','FontSize',15, ...
        'VerticalAlignment','middle');
end

%print('E:\MATLAB\WQX\Project2\2025_09_25_Output-Results\Results\Fig4.png', '-dpng', '-r1000');




