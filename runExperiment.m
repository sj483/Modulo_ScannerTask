function [] = runExperiment()

clear all; %#ok<CLALL>
SubjectId = getSubjectId();
for iRun = 1:5
    runRun(SubjectId,iRun);
    pause;
end

return