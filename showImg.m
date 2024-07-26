function [globals] = showImg(fieldIdx,duration,globals)

% Draw the texture
Screen('DrawTexture', ...
    globals.window, ...
    globals.textures((fieldIdx+1)), ...
    [], ...
    globals.xyEdgesCues, 0);

% Flip the screen
globals.t = Screen('Flip', globals.window, globals.t);

% Update globals.t so the texture is shown for the intended duration
waitframes = round(duration / globals.ifi);
globals.t = (globals.t + (waitframes - 0.5) * globals.ifi);
% Note on the -0.5 value above: Without subtracting 0.5, the flip might
% consistently occur slightly later than intended, leading to an
% accumulated error Subtracting 0.5 averages the timing error over multiple
% frames, effectively aligning the flips closer to the intended time.

return