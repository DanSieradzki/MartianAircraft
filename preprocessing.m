% *** HELP ***
% [Cd0,gM,SA,AR,acW,acWeight,landingLine,h] = preprocessing(chord,span,acMass,landingElev,altIntervals,UpperLim)
% Initial parameter processing and altitude indexing 
% Cd0 = zero-lift drag coefficient component
% gM = Martian gravitational constant (m/s^2)
% SA = Wing Surface Area (m^2)
% AR = Wing Aspect Ratio
% acWeight = Aircraft weight (N)
% landingLine = Matrix with landing elevation value for graphs (m)
% h = Height range matrix (m)
% eqDiameter = Equatorial diameter of Mars (m)
% eqCirc = Equatorial circumference of Mars (m)
% polDiameter = Polar diameter of Mars (m)
% polCirc = Polar circumference of Mars (m)

function [Cd0,gM,SA,AR,acWeight,landingLine,h,eqCirc,polCirc,eqArc1deg,polArc1deg] = preprocessing(chord,span,acMass,landingElev,altIntervals,UpperLim)
Cd0=0.001;
gM=3.71; 
SA=chord*span;
AR=(span^2)/SA;
acWeight=acMass*gM*ones(altIntervals,1);
landingLine=landingElev*ones(altIntervals,1);
h=linspace(landingElev,UpperLim,altIntervals)';
eqDiameter=6794000;
eqCirc=pi*eqDiameter;
eqArc1deg=eqCirc/360;
polDiameter=6752000;
polCirc=pi*polDiameter;
polArc1deg=polCirc/360;
end