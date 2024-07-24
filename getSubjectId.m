function [SubjectId] = getSubjectId()

% Get Subject number
UserInput = inputdlg({'Enter SubjectId (string):'},'SubjectId',1);
SubjectId = UserInput{1};

% Confirm details
ConfStr = sprintf(...
    'Experiment ready to begin...%cSubjectId: %s%cIs this detail correct and do you wish to continue?',...
    10,SubjectId,10);
ConfirmDlg = questdlg(ConfStr,'Confirm details','YES','NO','NO');
if ~strcmp(ConfirmDlg,'YES')
    error('Script terminated by user!');
end

return