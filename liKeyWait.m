function [keyIds,keyTime] = liKeyWait(allowableKeys,tTimeOut)
keyIds = NaN;
keyTime = NaN;
while true
    [keyIsDown, t, keyCode] = KbCheck(-3);

    % Check whether a key has been pressed ...
    if keyIsDown
        Ids = find(keyCode);
        Ids = Ids(ismember(Ids,allowableKeys));
        if ~isempty(Ids)
            keyIds = Ids;
            keyTime = t;
            break
        end
    end

    % Check whether a the max time has been reached ...
    if t >= tTimeOut
        keyTime = t;
        break
    end
end
return