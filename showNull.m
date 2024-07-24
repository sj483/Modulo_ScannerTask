function [globals] = showBlank(duration,globals)
% Now fill the screen black for 8 seconds
Screen('FillRect', globals.window, [0 0 0], globals.screenRect);

globals.t = Screen('Flip', globals.window, globals.t);


% Note on the - 0.5 used below: Without subtracting 0.5, the flip might
% consistently occur slightly later than intended, leading to an
% accumulated error Subtracting 0.5 averages the timing error over multiple
% frames, effectively aligning the flips closer to the intended time.
waitframes = round(duration / globals.ifi);
globals.t = (globals.t + (waitframes - 0.5) * globals.ifi);

end