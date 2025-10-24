function [UserVar,as,ab,dasdh,dabdh]=DefineMassBalance(UserVar,CtrlVar,MUA,time,s,b,h,S,B,rho,rhow,GF)

path='D:\WQX\MATLAB\Data_usedByUa\ISMIP6';
X1=load(fullfile(path, 'CCSM4_2km_anomaly_rcp85_1995-2100.mat'),'data');
load(fullfile(path, 'CCSM4_2km_clim_rcp85_1995-2014.mat'),'smb_clim');
x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);
t=ceil(time)+26;  % start from 2020
SMB_anomaly(:,t)=X1.data(t).smb_anomaly(x,y);
SMB_clim=smb_clim(x,y);   % units kg/(m^2 s)
SMB=(SMB_anomaly(:,t)+SMB_clim)*31556926/1000*1028/910;
as=SMB ;
path2='D:\WQX\MATLAB\Data_usedByUa\BMB';
X2=load(fullfile(path2, 'BasinsInterpolant.mat'));
X3=load(fullfile(path2, 'BMB_Amery_CCSM4_9_Points.mat'));
PICO_opts = struct;
PICO_opts.algorithm = 'watershed';%'polygon','oneshelf','watershed';
PICO_opts.C1 = 1e6;
PICO_opts.gamTstar = 1.5e-4;  %20250506 Version2
PICO_opts.nmax = 10; %20250506 Version2
PICO_opts.minArea = 2e9;
PICO_opts.minNumShelf = 20;
PICO_opts.SmallShelfMelt = 0;
PICO_opts.PICOres = 10000; % resolution in km (for watershed algorithm only)
PICO_opts.BasinsInterpolant = X2.Fbasins;
PICO_opts.FloatingCriteria = 'GLthreshold'; %'GLthreshold' or 'StrictDownstream'
PICO_opts.persistentBC = 0;
PICO_opts.InfoLevel = 1; %20250506 Version2
Sbasinswqx=X3.Salinity(t-5);Tbasinswqx=X3.Temperature(t-5);
% these two vectors are the salinity and temperature of each basin in the BasinsInterpolant file - provided by Ronja
PICO_opts.Sbasins = [34.6505;34.5273;34.3222;34.3259;34.3297;Sbasinswqx;34.4819;34.5666;34.5766;34.6677;34.7822;34.6254;34.4107;34.5526;34.6902;34.6668;34.5339;34.5849;34.6644];
PICO_opts.Tbasins = [-1.75725;-1.65931;-1.58212;-1.54757;-1.51301;Tbasinswqx;-1.69117;-0.67609;-1.61561;-1.30789;-1.83764;-1.5798;-0.368398;0.45505;1.04046;1.17196;0.229878;-1.23091;-1.79334];

PICO_opts.MeshBoundaryCoordinates = CreateMeshBoundaryCoordinatesFromShp(CtrlVar,UserVar);
ab = PICO(UserVar,CtrlVar,MUA,GF,h,median(rho),rhow,PICO_opts);
dasdh=0;
dabdh=0;

%% below:Version 1; the upper:Version 2 Cited by QinQing 20250506 C1=12000000,gam= 0.00015   
% PICO_opts.C1 = 1e6; 
% PICO_opts.gamTstar = 2e-5;
% PICO_opts.nmax = 3;
% PICO_opts.InfoLevel = 0; 

end
