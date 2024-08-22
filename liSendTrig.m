function [] = liSendTrig(trigId,globals)
if globals.sendTriggers
    io64(globals.portObj,globals.portAddress,255);
    WaitSecs((trigId+1)*globals.portUnitLength);
    io64(globals.portObj,globals.portAddress,0);
end
return