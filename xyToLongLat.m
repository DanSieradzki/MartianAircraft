% *** HELP ***
% [longPlot,latPlot] = xyToLongLat (guidePath,eqArc1deg,polArc1deg)
% converts x and y coordinates to longitude and latitude coordinates
% longPlot = plottable longitudinal coordinates matrix
% latPlot = plottable latitudinal coordinates matrix

function [longPlot,latPlot] = xyToLongLat (guidePath,eqArc1deg,polArc1deg)
longPlot=guidePath(:,3)/eqArc1deg;
latPlot=guidePath(:,4)/polArc1deg;
end