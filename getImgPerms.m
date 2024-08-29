function [] = getImgPerms()
Register = webread('http://b01.learningandinference.org/GetRegister.php');
SubjectIds = cellfun(@(s)append('x', s), {Register.SubjectId}',...
    'UniformOutput',false);
ImgPerms = {Register.ImgPerm}';
ImgPerms = cellfun(@(s)str2num(s),ImgPerms,...
    'UniformOutput',false); %#ok<ST2NM>
ImgPerms = cell2struct(ImgPerms,SubjectIds);
save('ImgPerms.mat','ImgPerms');
return