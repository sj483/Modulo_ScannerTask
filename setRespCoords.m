function [xyEdgesResp, xyCentreResp] = setRespCoords(nX, nY)

imgWidth = round((6/27)*nX);
numRows = 2;
numPerRow = 3;

%% Calculate the space between image in the x and y directions
blankX = (nX - numPerRow*imgWidth) / (numPerRow + 1);
blankY = (nY - numRows*imgWidth) / (numRows + 1);


%% Calculate the x and y co-ords of the centres of each response textures
xCents = linspace(...
        blankX + imgWidth/2, .... startX
        nX - (blankX + imgWidth/2), .... endX
        numPerRow);
yCents = linspace(...
        blankY + imgWidth/2, .... startY
        nY - (blankY + imgWidth/2), .... endY
        numRows);
xyCentreResp = nan(2,6);
xyCentreResp(1,:) = repmat(xCents,1,2);
xyCentreResp(2,:) = kron(yCents,[1,1,1]);


%% Calculate the x and y co-ords of the edges of each response texture
xyEdgesResp = nan(4,6); % Each column will contain 4 numbers...
% 1: the x-coordinate of the left edge of the rectangle;
% 2: the y-coordinate of the top edge of the rectangle;
% 3: the x-coordinate of the right edge of the rectangle;
% 4: the y-coordinate of the bottom edge of the rectangle;
for iImg = 1:6
    xyEdgesResp(:,iImg) = CenterRectOnPoint(...
        [0 0 imgWidth imgWidth],...
        xyCentreResp(1, iImg), xyCentreResp(2, iImg));
end

return