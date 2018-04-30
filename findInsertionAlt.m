% *** HELP ***
% [insertionAlt,insertionAltMat] = findInsertionAlt(Lift,acWeight,h)
% Finds insertion altitude by finding the intersection of aircraft weight
% and lift generated with altitude
% insertionAlt = altitude where lift generated is equal to weight of aircraft
% emptyMat = boolean condition to trigger explanation for common error of script

function [insertionAlt] = findInsertionAlt(Lift,acWeight,h)
invLift=transpose(Lift);
transpACweight=transpose(acWeight);
transpH=transpose(h);
insertionAltMat=InterX([invLift;transpH],[transpACweight;transpH]);
emptyMat = isempty(insertionAltMat);
if emptyMat == 1
    warning('Lift curve and aicraft weight do not intersect, please alter input paramaters')
else
insertionAlt=insertionAltMat(2,1);
end