% *** HELP ***
% Main run file for Martian atmosphere and aircraft analysis 
% landingElev = landing surface elevation (to be taken from geographical target location (m)
% UpperLim = Upper altitude bound for analysis (m)
% altIntervals =  Number of data point intervals
% date = value to return best known insertion altitude is 500.3 (coldest time of year at coldest time of day)
% select non-integer value equal or between 1 and 668 to select time of year, i.e. Spring: 1-94, Summer: 195-372, Autumn: 373-514, Winter, 515-668
% select value equal to or between 0 and 0.9 to denote time of day, i.e. midnight is 0.0 and midday is 0.5
% Vinf = Freestream velocity or velocity of aircraft (m/s)
% chord = Mean chord length of aircraft (m)
% span = Wingspan of aircraft (m)
% e = Oswald efficiency
% acMass = Mass of aircraft (kg)
% R = Radius of spiral (m)
% long = Longitudinal insertion position (°)
% lat = Latitudinal insertion position (°)

clear;
clc;
close all;

%******************Inputs section start******************
% Read help section before modifying inputs
landingElev=-2154; %Viking 2:-4542, Nili Fossae avg:-2154, Nili Fossae min:-4308
UpperLim=7000; 
altIntervals=10; 
date=375.5; 
Vinf=65;
chord=1; 
span=8;
e=0.8;
acMass=60;
R=2500;
long=75;
lat=22;
%******************Input section end******************

[Cd0,gM,SA,AR,acWeight,landingLine,h,eqCirc,polCirc,eqArc1deg,polArc1deg] = preprocessing(chord,span,acMass,landingElev,altIntervals,UpperLim);
[X,Y] = longLatToXY (long,lat,eqArc1deg,polArc1deg);
[tK,tC,baseT,p,rho,c,Re,q]=getMarsProperties(h,date,Vinf,chord);

[Cl,Cd,Lift,Drag,LD,glideAngle] = liftForces(AR,e,Cd0,q,SA);
[phi,glideRatio,dH,spiralLD,spiralCl,spiralCd,spiralGlideAngle] = spiralForces(Vinf,gM,R,LD,AR,e,Cd0,altIntervals);

[insertionAlt] = findInsertionAlt(Lift,acWeight,h);

[totalTM,guidePath,numRevs] = spiralGuide(dH,R,insertionAlt,landingElev,altIntervals,Vinf,X,Y);
disp('insertion altitude (m)');
disp(insertionAlt);
disp('Flight time (min)');
disp(totalTM);
disp('Total revolutions');
disp(numRevs);
disp('Bank angle (°)');
disp(phi);
disp('Altitude change per revolution (m)');
disp(-dH);

longPlot=guidePath(:,3)/eqArc1deg;
latPlot=guidePath(:,4)/polArc1deg;

plots(Vinf,rho,h,p,tC,c,Re,Lift,Drag,LD,acWeight,spiralLD,spiralCl,spiralCd,glideAngle,spiralGlideAngle,landingLine,insertionAlt,altIntervals,guidePath,longPlot,latPlot);