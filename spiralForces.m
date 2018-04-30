% *** HELP ***
% [phi,glideRatio,dH,spiralLD,spiralCl,spiralCd,spiralGlideAngle] = spiralForces(Vinf,gM,R,LD,AR,e,Cd0,altIntervals)
% calculates parameters key to banked flight
% phi = Bank angle (°)
% n = Load factor
% glideRatio = optimal glide ratio for banked turn
% dH = vertical velocity (m/s)
% spiralLD = Lift to Drag ratio for banked turn against altitude
% spiralCl = Coefficient of lift against altitude
% spiralCd = Coefficient of drag against altitude
% spiralGlideAngle = Optimal glide angle during a banked turn

function [phi,glideRatio,dH,spiralLD,spiralCl,spiralCd,spiralGlideAngle] = spiralForces(Vinf,gM,R,LD,AR,e,Cd0,altIntervals)
phi=atand((Vinf^2)/(gM*R));
n=1/(cos(phi));
glideConst=(cosd(phi)+(secd(phi)));
glideRatio=2/glideConst;
spiralLD=LD*glideRatio;
dH=[];
for n=1:altIntervals
deltaH=pi*R*glideConst*(1/(spiralLD(n:1)));
dH=vertcat(dH,deltaH);
end
dH=dH(1,1);

spiralCl=[];
spiralCd=[];
for n=1:altIntervals
spiralCl=vertcat(spiralCl,transpose((pi*AR*e)/(spiralLD(n,1))));
spiralCd=vertcat(spiralCd,Cd0+((spiralCl(n,1).^2)/(pi*AR*e)));
end

spiralGlideAngle=atan(spiralLD);
spiralGlideAngle=spiralGlideAngle(:,1);
end