function [waitframes] = getWaitFrames(presSecs,globals)
    waitframes = round(presSecs/globals.ifi)
end    