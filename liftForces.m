% *** HELP ***
% [Cl,Cd,Lift,Drag,LD,glideAngle] = liftForces(AR,e,Cd0,q,SA)
% Calculates Lift and Drag based on Cl and Cd as well as aircraft design parameters and therefore L/D and optimal glide angle for straight flight
% Cl = Coefficient of lift
% Cd = Coefficient of drag
% LD = Lift to Drag ratio
% glideAngle = optimal glide angle for associated L/D value.

function [Cl,Cd,Lift,Drag,LD,glideAngle] = liftForces(AR,e,Cd0,q,SA)
Cl=1;
Cd=Cd0+((Cl.^2)/(pi*AR*e));
Lift=q*SA*Cl;
Drag=q*SA*Cd;
LD=Lift/Drag;
LD=LD(:,1);
glideAngle=atan(LD);
glideAngle=glideAngle(:,1);
end
