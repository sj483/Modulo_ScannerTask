function [RT, r, tPageStart] = runTrial(a, b, arrayPerm, isiLength, globals, f, type)
s = globals.symbImg;
%feed the values for that row of TaskIO into the trial loop steps
globals = showImg(a, 3, globals); % the first argument is the time to wait before flippig to this slide
globals = showCross(globals); 
globals = showImg(b, 3, globals); % this is show B
globals = showSymb(type, 1, globals); %this is show Symbol

% this will randomise the cursor position based on the random
% ..arrayPerm, cursorPos also needs to be nonzero so is derived
% from an index
cursorPos = find(arrayPerm==1) ;
start = 0; % this is for checking if this is their first keypress
drawRespArray(globals, arrayPerm, cursorPos, [0,0,1]);
allowableKeys = [globals.scrollKey, globals.acceptKey];

tPageStart = GetSecs();
tTimeOut = (tPageStart + 6); %this is hard coded for 6 seconds after the while loop starts
keyTime = 0;
r = [];
while keyTime < tTimeOut
    [keyIds, keyTime] = liKeyWait(allowableKeys, tTimeOut);
    if keyIds == globals.scrollKey & isempty(r)
        cursorPos = (mod((cursorPos), 6)) + 1;
        disp(cursorPos)
        start = start + 1;
        if start == 1
            RT = keyTime;
        end
        drawRespArray(globals, arrayPerm, cursorPos, [0,0,1]);
        WaitSecs(0.3);
    elseif keyIds == globals.acceptKey
        r = arrayPerm(cursorPos);
        start = start + 1;
        if start == 1
            RT = keyTime;
        end
        drawRespArray(globals, arrayPerm, cursorPos, [0,1,1]);
    else
        if isempty(r)
        RT = [];
        r = 'timedOut';
        %else
        %   t = GetSecs(); % this option is to end the
        % loop in the scenario where no keys are pressed
        end
    end
end
end
