path='E:\MATLAB\WQX\Project2\20250506秦青PICO\New_Outputs';
data=load(fullfile(path, '0000000-HadGEM2_RCP85_Forward80.mat'));
Observe=load('Basal_Melt_Rate.mat');
MMM=load("Avg_BM.mat");
x=data.MUA.coordinates(:,1);  y=data.MUA.coordinates(:,2);

%%

Mi = MMM.Mi;                     % 多模型均值（融化为正，m a^-1）
Oi = Observe.MeltRate(x, y);     % 观测（同网格、同单位）

% 有效掩膜：模型、观测都有限；且在浮冰架上
% valid = isfinite(Oi)  & (data.GF.node==0);
valid = isfinite(Mi) & isfinite(Oi) & (data.GF.node==0);
% 面积权重（0/1），NaN 点权重为 0
wi = double(valid);

% 将无效点的值设为 0，避免 NaN 传播
Mi2 = Mi;    Mi2(~valid) = 0;
Oi2 = Oi;    Oi2(~valid) = 0;

% ==== 加权平均 ====
denW  = sum(FEintegrate2D([], data.MUA, wi));           % \sum_i w_i
numMw = sum(FEintegrate2D([], data.MUA, Mi2 .* wi));    % \sum_i w_i M_i
numOw = sum(FEintegrate2D([], data.MUA, Oi2 .* wi));    % \sum_i w_i O_i

Mbar = numMw / denW;
Obar = numOw / denW;

% ==== 加权相关系数 r ====
dM = (Mi - Mbar); dM(~valid) = 0;   % 去均值后在无效处置 0
dO = (Oi - Obar); dO(~valid) = 0;

num = sum(FEintegrate2D([], data.MUA, wi .* dM .* dO));         % \sum w_i dM dO
denM = sum(FEintegrate2D([], data.MUA, wi .* dM .* dM));        % \sum w_i dM^2
denO = sum(FEintegrate2D([], data.MUA, wi .* dO .* dO));        % \sum w_i dO^2
r    = num / sqrt(denM * denO);

fprintf('Area-weighted means: Mbar=%.3f, Obar=%.3f (m/a);  r=%.3f\n', Mbar, Obar, r);
%  Area-weighted means: Mbar=0.056, Obar=0.743 (m/a);  r=0.755  取观测与模拟都有的值
%  Area-weighted means: Mbar=0.244, Obar=NaN (m/a);  r=NaN      只关注模拟的有效值
%  Area-weighted means: Mbar=0.056, Obar=0.743 (m/a);  r=0.755  只关注观测的有效值
%%
% 仍然只在有效的浮冰架网格上评估
Di = Mi - Oi;                % 差值场（模型-观测）
Di2 = Di;   Di2(~valid) = 0; % 无效处置 0

% 面积加权 Bias（空间平均偏差，>0 表示整体高估，<0 表示低估）
Bias = sum(FEintegrate2D([], data.MUA, wi .* Di2)) / sum(FEintegrate2D([], data.MUA, wi));

% 面积加权 RMSE（空间均方根误差）
RMSE = sqrt( sum(FEintegrate2D([], data.MUA, wi .* (Di2.^2))) / sum(FEintegrate2D([], data.MUA, wi)) );

fprintf('Area-weighted Bias = %.3f m/a,  RMSE = %.3f m/a\n', Bias, RMSE);

% Area-weighted Bias = -0.687 m/a,  RMSE = 2.185 m/a



