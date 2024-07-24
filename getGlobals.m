function [globals] = getGlobals(globals)

% Keyboard settings
KbName('UnifyKeyNames');
globals.escapeKey = KbName('ESCAPE');
globals.scrollKey = KbName('b');
globals.acceptKey = KbName('y');

%% 
[globals.white, globals.black] = setMonochromes();

%%
[globals.window, windowRect] = PsychImaging('OpenWindow', 0, globals.black);

%% Load the textures
globals.textures = setTextures(globals.window, globals.SubjectId);
globals.symbImg = setSymTextures(globals.window);

%% Set the xy co-ords
% Get the size of the on screen window
[nX, nY] = Screen('WindowSize', globals.window);

% Get the centre coordinates of the window
[x,y] = RectCenter(windowRect);
globals.xyCentreScrn = [x;y];
globals.xyEdgesScrn = Screen('Rect', globals.window);

% Cues
cueImgWidth = 830;
globals.xyEdgesCues = CenterRectOnPoint(...
    [0 0 cueImgWidth cueImgWidth],...
    globals.xyCentreScrn(1), globals.xyCentreScrn(2));

% Resp
[globals.xyEdgesResp, globals.xyCentreResp] = setRespCoords(nX, nY);


%%
% Query the frame duration
globals.ifi = Screen('GetFlipInterval', globals.window);

% Pen width for drawing the frames
globals.penWidthPixels = 6;


% Get an initial screen flip for timing
globals.t = Screen('Flip', globals.window);

%%
globals.cross = setCross();

return