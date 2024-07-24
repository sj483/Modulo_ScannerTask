function [] = setUp(window)

PsychDefaultSetup(2);

% Retreive the maximum priority number and set the execution priority of your script
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% Last argument below:
% ... 0: Don't skip the sync-test
% ... 2: Skip the sync-test
Screen('Preference','SkipSyncTests', 0);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

return