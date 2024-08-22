function [portObj,portAddress,status] = setIOPort()
config_io;
portObj = io64;
status = io64(portObj);
portAddress = hex2dec('3FF8');
return