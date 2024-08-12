function [globals] = showImg(fieldIdx,duration,globals)

% Draw the texture
Screen('DrawTexture', ...
    globals.window, ...
    globals.textures((fieldIdx+1)), ...
    [], ...
    globals.xyEdgesCues, 0);

% Flip the screen
Screen('Flip', globals.window, globals.t);

% Update globals.t so the texture is shown for the intended duration
waitframes = round(duration / globals.ifi);
globals.t = globals.t + (waitframes * globals.ifi);

return