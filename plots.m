% *** HELP ***
% [] = plots(Vinf,rho,h,p,tC,c,Re,Lift,Drag,LD,acWeight,spiralLD,spiralCl,spiralCd,glideAngle,spiralGlideAngle,landingLine,insertionAlt,altIntervals,guidePath,longPlot,latPlot)
% Function to plot all results of script
% atmRows = Rows of graphs for subplots in Atmospheric data figure
% atmColumns = Columns of graphs for subplots in Atmospheric data figure
% acRows = Rows of graphs for subplots in striaght flight figure
% acColumns = Columns of graphs for subplots in striaght flight figure
% acSpiralRows = Rows of graphs for subplots in spiral flight figure
% acSpiralColumns = Columns of graphs for subplots in spiral flight figure

function [] = plots(Vinf,rho,h,p,tC,c,Re,Lift,Drag,LD,acWeight,spiralLD,spiralCl,spiralCd,glideAngle,spiralGlideAngle,landingLine,insertionAlt,altIntervals,guidePath,longPlot,latPlot)
insertionLine=(insertionAlt*ones(altIntervals,1));

figure('Name','Martian Atmospheric Data');
atmRows=2;
atmColumns=2;

subplot(atmRows,atmColumns,3), f1=plot(rho,h);
title('Altitude vs. Density');
xlabel('Density (kg/m^3)');
ylabel('Altitude (m)');

subplot(atmRows,atmColumns,2), f2=plot(p,h);
title('Altitude vs. Pressure');
xlabel('Pressure (kPa)');
ylabel('Altitude (m)');

subplot(atmRows,atmColumns,1), f3=plot(tC,h);
title('Altitude vs. Temperature');
xlabel('Temperature (°C)');
ylabel('Altitude (m)');

subplot(atmRows,atmColumns,4), f4=plot(c,h);
title('Altitude vs. Speed of Sound');
xlabel('Speed of Sound (m/s)');
ylabel('Altitude (m)');

figure('Name','Martian Aircraft Data, Straight Path');
acRows=3;
acColumns=2;

subplot(acRows,acColumns,1), f11=plot(Re,h,Re,landingLine,'g--',Re,insertionLine,'black--');
title('Altitude vs. Reynolds Number');
xlabel('Reynolds Number');
ylabel('Altitude (m)');
legend('Re','landingLine','insertionLine');

AircraftWeight=acWeight;
landingLine3=linspace((min(Drag)),(max(Lift)),altIntervals);
subplot(acRows,acColumns,2), f12=plot(Lift,h,Drag,h,AircraftWeight,h,landingLine3,landingLine,'g--',landingLine3,insertionLine,'black--');
title('Altitude vs. Lift');
xlabel('Lift (N)');
ylabel('Altitude (m)');
legend('Lift','AircraftWeight','landingLine','insertionLine');

subplot(acRows,acColumns,3), f13=plot(LD,h,LD,landingLine,'g--',LD,insertionLine,'black--');
title('Altitude vs. L/D');
xlabel('L/D');
ylabel('Altitude (m)');
legend('L/D','landingLine','insertionLine');

Mach=[];
for n=1:altIntervals
M=(Vinf)/c(n,:);
Mach=vertcat(Mach,M(:,1));
end
subplot(acRows,acColumns,4), f14=plot(Mach,h,Mach,landingLine,'g--',Mach,insertionLine,'black--');
title('Altitude vs. Mach number');
xlabel('Mach number');
ylabel('Altitude (m)');
legend('Mach','landingLine','insertionLine');

subplot(acRows,acColumns,5), f23=plot(glideAngle,h,glideAngle,landingLine,'g--',glideAngle,insertionLine,'black--');
title('Altitude vs. Optimal Glide Angle');
xlabel('Optimal Glide Angle (°)');
ylabel('Altitude (m)');
legend('glideAngle','landingLine','insertionLine')

figure('Name','Martian Aircraft Data, Spiral Path');
acSpiralRows=2;
acSpiralColumns=2;

subplot(acSpiralRows,acSpiralColumns,1), f21=plot(spiralLD,h,spiralLD,landingLine,'g--',spiralLD,insertionLine,'black--');
title('Altitude vs. banked L/D');
xlabel('L/D');
ylabel('Altitude (m)');
legend('spiralLD','landingLine','insertionLine')

landingLine4=linspace((min(spiralCd)),(max(spiralCl)),altIntervals);
subplot(acSpiralRows,acSpiralColumns,2), f22=plot(spiralCl,h,spiralCd,h,landingLine4,landingLine,'g--',landingLine4,insertionLine,'black--');
title('Altitude vs. Cl and Cd');
xlabel('Cl & Cd');
ylabel('Altitude (m)');
legend('spiralCl','spiralCd','landingLine','insertionLine')

subplot(acSpiralRows,acSpiralColumns,3), f23=plot(spiralGlideAngle,h,spiralGlideAngle,landingLine,'g--',spiralGlideAngle,insertionLine,'black--');
title('Altitude vs. Optimal Banked Glide Angle');
xlabel('Optimal Banked Glide Angle (°)');
ylabel('Altitude (m)');
legend('spiralGlideAngle','landingLine','insertionLine')

figure('Name','Martian Aircraft Spiral Flight Path');
plot3(longPlot,latPlot,guidePath(:,5))
xlabel('Longitude (°)');
ylabel('Latitude (°)');
zlabel('Altitude (m)');
end