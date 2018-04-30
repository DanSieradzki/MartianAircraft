% *** HELP ***
% [tK,tC,baseT,p,rho,c,Re,q] = getMarsProperties(h,date,Vinf,chord)
% computes atmospheric properties on Mars for a given range of altitudes in metres
% tK = Temperature (K)
% tC = temperature (°C)
% p = pressure (kPa)
% rho = density (kg/m3)
% c = speed of sound (m/s)
% co2C = Sutherland's constant for CO2
% co2T0 = Reference temperature for CO2
% co2mu0 = Reference viscosity for CO2
% mu = viscosity of Martian air
% Re = Reynold's number of Martian air
% q = Dynamic Pressure

function [tK,tC,baseT,p,rho,c,Re,q] = getMarsProperties(h,date,Vinf,chord)
load V2AtmData.mat;
a=V2AtmData(:,1);%sort first column of matrix into seperate column vector
b=V2AtmData(:,2);%sort temperature (°C) column of matrix into seperate column vector
index=round(mean(find(round(a,1)==date)),0); %if multiple values for date, find middle value
baseT=b(index); %return base temperature

height = h;

if height <= 7000
    tempC = baseT-(0.000998*(height+4545.25));
else
    tempC = -23.4-(0.00222*(height+4545.25));
end

tempK = tempC + 273.15;
tempR =tempK*(9/5);
pressure = 0.699*exp(-0.00009*height); 
density = pressure/(0.1921*tempK);
density = density(:,1);
speedsound = sqrt(1.28*188.9*tempK); 
co2C=240;
co2T0=527.67;
co2mu0=0.01480;
muFactorA=(0.555*co2T0)+co2C;
muFactorB=(0.555*tempR)+co2C;
mu=(co2mu0*(muFactorA/muFactorB)*((tempR/co2T0).^1.5))/1000;
Re=(density*Vinf*chord)/mu;
q=0.5*density*(Vinf.^2);

tK = tempK;
tC = tempC; 
tR = tempR;
p = pressure;
rho = density;
c = speedsound;
end