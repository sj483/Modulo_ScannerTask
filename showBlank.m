function [globals] = showBlank(duration,globals)

% Draw a blank rectangle
Screen('FillRect', globals.window, [0 0 0], globals.xyEdgesScrn);

% Flip the screen
globals.t = Screen('Flip', globals.window, globals.t);


% Update globals.t so the blank screen is shown for the intended duration
waitframes = round(duration / globals.ifi);
globals.t = (globals.t + (waitframes - 0.5) * globals.ifi);
% Note on the -0.5 value above: Without subtracting 0.5, the flip might
% consistently occur slightly later than intended, leading to an
% accumulated error Subtracting 0.5 averages the timing error over multiple
% frames, effectively aligning the flips closer to the intended time.

return