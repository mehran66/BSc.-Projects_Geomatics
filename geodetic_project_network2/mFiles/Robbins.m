function [alfa12,s]=Robbins(Fi1,Lambda1,Fi2,Lambda2)
%Robbins' formulae [Cooper, 1987]:
deltaLambda=Lambda2-Lambda1;
deltaFi=Fi2-Fi1;
a = 6378137.000000;e=0.081819191;
N1=a/(1-(e^2)*((sin(Fi1))^2))^.5;
N2=a/(1-(e^2)*((sin(Fi2))^2))^.5;
t=((1-e^2)*tan(Fi2)+(e^2)*(N1*sin(Fi1))/(N2*cos(Fi2)));
alfa12 = (abs(acot((cos(Fi1)*t - sin(Fi1)*cos(deltaLambda))/sin(deltaLambda))))*180/pi;
if deltaFi>=0&& deltaLambda<0
    alfa12=2*180-alfa12;
end
if deltaFi<0&& deltaLambda<0
    alfa12=180+alfa12;
end
if deltaFi<0&& deltaLambda>0
    alfa12=180-alfa12;
end
alfa12=alfa12*pi/180;
sigma=asin(sin(deltaLambda)*cos(Fi2)/sin(alfa12));
z = e^2 /(1- e^2 );
h = sqrt(z*(cos(Fi1))^2* (cos(alfa12))^2);
g=sqrt(z*(sin(Fi1)^2));
s=N1*sigma*(1-(sigma^2)/6*(h^2)*(1-h^2)+(sigma^3)/8*g*h*(1-2*h^2)+(sigma^4)/120*(h^2*(4-7*h^2)-3*g^2*(1-7*h^2))-(sigma^5)/48*g*h);
