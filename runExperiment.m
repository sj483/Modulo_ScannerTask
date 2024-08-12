function [] = runExperiment()

clear all; %#ok<CLALL>
SubjectId = getSubjectId();
for iRun = 1:5
    if iRun > 1
        questdlg(...
            sprintf('Continue to run %i?',iRun),...
            'Continue?', ...
            'I am ready','I am ready');
    end
    runRun(SubjectId,iRun);
end

return