function [tScan0,globals] = waitForScanner(globals)

% Set the text size
Screen('TextSize', globals.window, 50);

% Draw the text
DrawFormattedText(globals.window, ...
    '...', ...
    'center', 'center', ...
    globals.white);

% Flip the screen
Screen('Flip', globals.window, globals.t);

% Wait for the first s key press
[~, tScan0] = liKeyWait(globals.sKey, Inf);
globals.t = tScan0;
return