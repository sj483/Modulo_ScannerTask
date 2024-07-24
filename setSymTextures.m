function [symImg] = setSymTextures(window)
%SET UP OF SYMBOL TEXTURE
%convert symbol files into pre-loaded texture
symImg = struct;
symImg.modPlus = ...
    Screen('MakeTexture', window, imread(".\Imgs\s00.png"));
symImg.oneBack = ...
    Screen('MakeTexture', window, imread(".\Imgs\s01.png"));
symImg.twoBack = ...
    Screen('MakeTexture', window, imread(".\Imgs\s02.png"));
return