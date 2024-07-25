function [symImg] = setSymTextures(window)
%SET UP OF SYMBOL TEXTURE
%convert symbol files into pre-loaded texture
symImg = struct;
symImg.modPlus = ...
    Screen('MakeTexture', window, imread(".\Imgs\S0.png"));
symImg.oneBack = ...
    Screen('MakeTexture', window, imread(".\Imgs\S1.png"));
symImg.twoBack = ...
    Screen('MakeTexture', window, imread(".\Imgs\S2.png"));
return