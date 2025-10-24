function [UserVar,CtrlVar,MeshBoundaryCoordinates]=DefineInitialInputs(UserVar,CtrlVar)
%% Input files
Interpolant_path = 'D:\WQX\MATLAB\Data_usedByUa';
UserVar.RunType='CCSM4_RCP85_Forward80';
UserVar.GeometryInterpolant=fullfile(Interpolant_path,'GeometryInterpolant_BMA_v3.mat');
UserVar.SurfaceVelocityInterpolant=fullfile(Interpolant_path,'VelocityInterpolant.mat');
UserVar.BoundaryShp =fullfile(Interpolant_path,'SHP\Amery_Simplify.shp');
MeshBoundaryCoordinates=CreateMeshBoundaryCoordinatesFromShp(CtrlVar,UserVar);
UserVar.Inverse_AGlen_C = 'AmeryInverse_AGlen_C-dhdt0.05.mat';
%% Transient run settings
CtrlVar.Experiment=UserVar.RunType;
CtrlVar.ReadInitialMesh=1;
CtrlVar.ReadInitialMeshFileName='UnstructuredMesh.mat';
CtrlVar.SaveInitialMeshFileName='WQXMeshInitial.mat';

CtrlVar.TimeDependentRun=1;
CtrlVar.AdaptMesh=0;
CtrlVar.MaxNumberOfIterations = 100; 
CtrlVar.dt=0.25; 
CtrlVar.AdaptiveTimeStepping=0;
CtrlVar.time=0;
CtrlVar.TotalNumberOfForwardRunSteps=500; 
CtrlVar.TotalTime=80;

%% restart set by WQX 20240508
CtrlVar.Restart=1;
CtrlVar.WriteRestartFile=1; 
CtrlVar.WriteRestartFileInterval=100;
CtrlVar.ResetTime=1 ;
CtrlVar.RestartTime=0; 
CtrlVar.ResetTimeStep=1;
CtrlVar.ResetRunStepNumber=0; 
CtrlVar.NameOfRestartFiletoRead='Relax20_20240916.mat'; 
CtrlVar.NameOfRestartFiletoWrite='CCSM4_RCP85_Result_Forward80.mat';
end

