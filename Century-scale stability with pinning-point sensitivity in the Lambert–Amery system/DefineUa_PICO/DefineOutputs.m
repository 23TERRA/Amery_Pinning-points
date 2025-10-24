function  UserVar=DefineOutputs(UserVar,CtrlVar,MUA,BCs,F,l,GF,InvStartValues,InvFinalValues,Priors,Meas,BCsAdjoint,RunInfo)

v2struct(F);
plots='plots-save-BCs-';
CtrlVar.QuiverColorPowRange=2; 
GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,GF,CtrlVar);
TRI=[]; DT=[]; xGL=[] ; yGL=[] ;
x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);
%%
if contains(plots,'-save-')
    % save data in files with running names
    % check if folder 'ResultsFiles' exists, if not create
    if strcmp(CtrlVar.DefineOutputsInfostring,'First call') && exist(fullfile(cd,'ResultsFiles'),'dir') ~= 1
        mkdir('ResultsFiles') ;
    end
    
    if strcmp(CtrlVar.DefineOutputsInfostring,'Last call')==0
        FileName=sprintf('ResultsFiles/%07i-%s.mat', round(100*CtrlVar.time), CtrlVar.Experiment);
        fprintf(' Saving data in %s \n',FileName)
        CtrlVarInRestartFile=CtrlVar; UserVarInRestartFile=UserVar;
        save(FileName,'CtrlVarInRestartFile','UserVarInRestartFile','MUA','BCs','F','l','GF');
    end
end

% only do plots at end of run
if ~strcmp(CtrlVar.DefineOutputsInfostring,'Last call') ; return ; end

if contains(plots,'-BCs-')
    %%
    figure ;
    PlotBoundaryConditions(CtrlVar,MUA,BCs)
    hold on ;
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'r');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    print(gcf, 'MuaBoundary.png', '-dpng', '-r600');
    %%
end
end
