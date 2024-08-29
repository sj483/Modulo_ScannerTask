function [] = testSetup() 

%% Clear the screen
sca;
close all;
%% Create the globals structure
clear global;
globals = struct;
globals.SubjectId = 'a1';
%% Set the globals
globals = getGlobals(globals);

%% Set-up PsychToolbox
setUp(globals.window)
penWidthPixels = 6;
allowableKeys = [globals.scrollKey, globals.acceptKey];
dateTimeStr = sprintf('%04d%02d%02dT%02d%02d%02d',round(clock)); %#ok<CLOCK>
targetFn = sprintf('.%sOutputs%s%s_R%i_%s.mat',...
    filesep, filesep, globals.SubjectId, dateTimeStr);


% Draw the rect to the screen
Screen('FrameRect', globals.window, [0,0,1].*globals.white, globals.xyEdgesScrn, penWidthPixels)
Screen('FrameRect', globals.window, [0,1,0].*globals.white, globals.xyEdgesResp, penWidthPixels)
Screen('FrameRect', globals.window, [1,0,0].*globals.white, globals.xyEdgesCues, penWidthPixels)

% Flip to the screen
tStart = Screen('Flip', globals.window);

tTimeOut = tStart + 300;
[kbIds, keyTime] = liKeyWait(allowableKeys,tTimeOut);

[keyNames] = KbName(kbIds);


try
    save(targetFn, "keyNames", "kbIds", "keyTime");
catch
    warning('Data not saved successfully');
end

KbStrokeWait
% Clear the screen
sca;

return