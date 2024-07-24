function [cross] = setCross()
crossWidth = 40;
lineWidthPix = 8;

xCoords = [-crossWidth/2, crossWidth/2, 0, 0];
yCoords = [0, 0, -crossWidth/2, crossWidth/2];
coords = [xCoords; yCoords];
cross.coords = coords;
cross.lineWidthPix = lineWidthPix;
return