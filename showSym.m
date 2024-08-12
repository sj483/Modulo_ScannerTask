function [globals] = showSym(type,duration,globals)

% Set the name of the symbol we are drawing based on the type input
if strcmp(type, '1Back')
    fieldName = 'oneBack';
elseif strcmp(type, '2Back')
    fieldName = 'twoBack';
else
    fieldName = 'modPlus';
end

% Draw the texture
Screen('DrawTexture', ...
    globals.window, ...
    globals.symbImg.(fieldName), ...
    [], ...
    globals.xyEdgesCues, 0);

% Flip the screen
Screen('Flip', globals.window, globals.t);

% Update globals.t so the texture is shown for the intended duration
waitframes = round(duration / globals.ifi);
globals.t = globals.t + (waitframes * globals.ifi);

return