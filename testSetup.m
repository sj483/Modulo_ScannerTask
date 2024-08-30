function [] = testSetup() 

% Clear the screen
sca;
close all;

%% Create the globals structure
clear global;
globals = struct;
globals.SubjectId = '47fed925';

%% Set the globals
globals = setGlobals(globals);

%% Set-up PsychToolbox
setUp(globals.window);
penWidthPixels = 6;
allowableKeys = [globals.scrollKey, globals.acceptKey];

%% Draw the rect to the screen
Screen('FrameRect', globals.window, [0,0,1].*globals.white, globals.xyEdgesScrn, penWidthPixels)
Screen('FrameRect', globals.window, [0,1,0].*globals.white, globals.xyEdgesResp, penWidthPixels)
Screen('FrameRect', globals.window, [1,0,0].*globals.white, globals.xyEdgesCues, penWidthPixels)

%% Flip to the screen
Screen('Flip', globals.window);

kbIds = liKeyWait(allowableKeys,Inf);
keyNames = KbName(kbIds);
disp(keyNames);
disp(kbIds);
KbStrokeWait;

%% Clear the screen
sca;

return