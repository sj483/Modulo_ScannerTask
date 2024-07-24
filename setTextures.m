function [textures] = setTextures(window,SubjectId)
imgPerms = load('ImgPerms.mat');
imgPerms = imgPerms.ImgPerms;
imgPerm = imgPerms.(SubjectId) + 1;
imageFns = {
    '.\Imgs\i00.png';
    '.\Imgs\i01.png';
    '.\Imgs\i02.png';
    '.\Imgs\i03.png';
    '.\Imgs\i04.png';
    '.\Imgs\i05.png'};
imageFns = imageFns(imgPerm);

imgFiles = cell(6,1);
for ii = 1:numel(imageFns)
    imgFiles{ii} = imread(imageFns{ii});
end

% Make the 6 sparks into textures
textures = nan(6,1);
for iSpark = 1:6
    textures(iSpark) = Screen('MakeTexture', window, imgFiles{iSpark});
end
return