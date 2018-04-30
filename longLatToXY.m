% *** HELP ***
% [X,Y] = longLatToXY (long,lat,eqArc1deg,polArc1deg)
% converts longitude and latitude coordinates to x and y coordinates
% X = plottable x coordinate denoting longitudinal distance from Mars' prime meridian (m)
% Y = plottable y coordinate denoting latitudinal distance from Mars' prime meridian (m)

function [X,Y] = longLatToXY (long,lat,eqArc1deg,polArc1deg)
X=eqArc1deg*long;
Y=polArc1deg*lat;
end