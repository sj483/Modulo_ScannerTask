function [TaskIO] = runRun(SubjectId,RunId)

if ~exist(sprintf('.%sOutputs',filesep),'dir')
    mkdir Outputs
end

dateTimeStr = sprintf('%04d%02d%02dT%02d%02d%02d',round(clock)); %#ok<CLOCK>
targetFn = sprintf('.%sOutputs%s%s_R%i_%s.mat',...
    filesep, filesep, SubjectId, RunId, dateTimeStr);

%% Create the globals structure
clear global;
globals = struct;
globals.SubjectId = SubjectId;

%% Set IO port
globals.sendTriggers = true;
try
    [globals.portObj,globals.portAddress] = setIOPort();
    io64(globals.portObj,globals.portAddress,0);
    choice = questdlg(...
        sprintf('Successfully setup IO port.%cWould you like to continue?',10),...
        'Continue?', ...
        'Exit execution','Let''s go!','Exit execution');
    switch choice
        case 'Exit execution'
            return
    end
catch
    choice = questdlg(...
        sprintf('Failed to setup IO port.%cWhat would you like to do?',10),...
        'IO port not working', ...
        'Exit execution','Continue; I am testing','Exit execution');
    switch choice
        case 'Exit execution'
            return
        case 'Continue; I am testing'
            globals.sendTriggers = false;
    end
end

%% Clear the screen
sca;
close all;

%% Set the globals
globals = setGlobals(globals);

%% Set-up PsychToolbox
setUp(globals.window);

%% Set TaskIO
TaskIO = setTaskIO(SubjectId,RunId);
HideCursor();

%% Wait for Scanner
[tScan0,globals] = waitForScanner(globals);

%% Trial loop
for iT = 1:numel(TaskIO)

    if strcmp(TaskIO(iT).TrialType,"Null")
        globals = showCross(8, globals);
    else

        % Set the trial characteristics
        trialType = TaskIO(iT).TrialType;
        a = TaskIO(iT).a;
        isiLength = TaskIO(iT).isiLength;
        b = TaskIO(iT).b;
        arrayPerm = TaskIO(iT).arrayPerm;
        startPos = TaskIO(iT).startPos;

        %% Display
        globals = showCross(1, globals);
        tShowA = globals.t;
        globals = showImg(a, 3, globals);
        liSendTrig(a+8,globals);
        globals = showBlank(isiLength, globals);
        tShowB = globals.t;
        globals = showImg(b, 3, globals);
        liSendTrig(b+16,globals);
        globals = showSym(trialType, 1, globals);

        %% Request response
        [r, tArray, tRespo, globals] = ...
            requestResponse(arrayPerm, startPos, 6, globals);

        %% Save to TaskIO
        TaskIO(iT).r = r;
        TaskIO(iT).tShowA = tShowA;
        TaskIO(iT).tShowB = tShowB;
        TaskIO(iT).tArray = tArray;
        TaskIO(iT).tRespo = tRespo;

        try
            save(targetFn, "TaskIO", "tScan0", "globals");
        catch
            warning('Data not saved successfully on trial %i', iT);
        end

        %% Escape
        [~, ~, keyCode] = KbCheck(-3);
        if keyCode(globals.escapeKey)
            sca;
            break
        end
    end
end

%% Switch running priority of PTB back to normal
Priority(0);
return