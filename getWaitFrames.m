function [waitframes] = getWaitFrames(secs,globals)
waitframes = round(secs/globals.ifi);
return