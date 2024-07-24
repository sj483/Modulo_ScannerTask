function [r, tStart, tRespo, globals] = requestResponse(arrayPerm, startPos, duration, globals)
allowableKeys = [globals.scrollKey, globals.acceptKey];

cursorPos = startPos;
tStart = drawRespArray(arrayPerm, cursorPos, [0,0,1].*globals.white, globals);

tTimeOut = (tStart + duration);
r = NaN;
tRespo = NaN;
now = GetSecs();
tLastValidScroll = -Inf;
while now < tTimeOut
    [keyIds, keyTime] = liKeyWait(allowableKeys, tTimeOut);
    globals.t = keyTime;
    if ismember(globals.scrollKey,keyIds) && isnan(r)
        if keyTime > (tLastValidScroll + 0.25)
            liSendTrig(254, globals);
            cursorPos = (mod((cursorPos), 6)) + 1;
            drawRespArray(arrayPerm, cursorPos, [0,0,1].*globals.white, globals);
            tLastValidScroll = keyTime;
        end
    elseif ismember(globals.acceptKey,keyIds)
        liSendTrig(255, globals);
        r = arrayPerm(cursorPos);
        drawRespArray(arrayPerm, cursorPos, [0,1,1].*globals.white, globals);
        tRespo = keyTime;
    end
    now = GetSecs();
end
if isnan(r)
    r = arrayPerm(cursorPos).*1i;
end
globals.t = tTimeOut;
end