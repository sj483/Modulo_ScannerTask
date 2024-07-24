function [] = liSendTrig(trigId,globals)
if globals.sendTriggers
    io64(globals.portObj,globals.portAddress,trigId);
end
return