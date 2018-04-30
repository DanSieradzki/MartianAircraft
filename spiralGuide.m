% *** HELP ***
% [totalTM,guidePath,numRevs] = spiralGuide(dH,R,insertionAlt,landingElev,Vinf,X,Y)
% Returns velocities in horizontal, vertical and lateral directions,
% changes in heading and total flight time in minutes
% spiralCirc = circumference of one revolution of spiral (m)
% spiralArc1deg = arc length of 1° of spiral circumference (m)
% spiralT360 = time for aircraft to travel along full circumference (s)
% spiralT1 = time for aircraft to travel along 1° arc (s)
% horCirc = 2D flat plane circumference of spiral circumference, as seen from above (m)
% horArc1deg = arc lenfth of 1° of 2D circular circumference (m)
% horV = velocity of aircraft tangential to the spiral in the horizontal 2D plane (m/s)
% vertV = velocity of aircraft vertically (m/s)
% latArc1deg = lateral distance travelled over course of 1° arc (m)
% latV = velocity of aircraft laterally (m/s)
% dHeading = change in heading of aircraft over course of 1° arc (°)
% numRevs = number of complete revolutions completed over course of whole flight
% totalTS = time taken to complete whole flight (s)
% totalTS = time taken to complete whole flight (min)
% guidePath = matrix containing time indexing, heading and x,y,z coordinates for spiral flight path
% timeInt = time interval between data points in spiral path
% guidePathT = time index
% guidePathHeading = Heading as a function of time
% guidePathX = X coordinate as a function of time
% guidePathY = Y coordinate as a function of time
% guidePathZ = Z coordinate as a function of time

function [totalTM,guidePath,numRevs] = spiralGuide(dH,R,insertionAlt,landingElev,altIntervals,Vinf,X,Y)
spiralCirc=((dH.^2)+((2*pi*R)^2)).^0.5;
spiralArc1deg=spiralCirc/360;
spiralT360=spiralCirc/Vinf;
spiralT1deg=spiralT360/360;

horCirc=2*pi*R;
horArc1deg=horCirc/360;
horV=horArc1deg/spiralT1deg;

vertV=dH/spiralT360;

latArc1deg=2*R*sind(0.5)*sind(1);
latV=latArc1deg/spiralT1deg;
dHeading=1/spiralT1deg;

numRevs=(insertionAlt-landingElev)/dH;
totalTS=numRevs*spiralT360;
totalTM=totalTS/60;

guidePath=[0 0 X Y insertionAlt];
timeInt=1;
for n=2:1:(totalTS/timeInt)
guidePathT=guidePath(n-1,1)+timeInt;
guidePathHeading=guidePath(n-1,2)+dHeading;
guidePathX=guidePath(n-1,3)+(timeInt.*horV.*cosd(guidePath(n-1,2)-(dHeading/2)));
guidePathY=guidePath(n-1,4)-(timeInt.*horV.*sind(guidePath(n-1,2)-(dHeading/2)));
guidePathZ=guidePath(n-1,5)-(timeInt*vertV);
guidePath=vertcat(guidePath,[guidePathT guidePathHeading guidePathX guidePathY guidePathZ]);
end
end