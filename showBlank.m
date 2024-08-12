function [globals] = showBlank(duration,globals)

% Draw a blank rectangle
Screen('FillRect', globals.window, [0 0 0], globals.xyEdgesScrn);

% Flip the screen
Screen('Flip', globals.window, globals.t);


% Update globals.t so the blank screen is shown for the intended duration
waitframes = round(duration / globals.ifi);
globals.t = globals.t + (waitframes * globals.ifi);

return