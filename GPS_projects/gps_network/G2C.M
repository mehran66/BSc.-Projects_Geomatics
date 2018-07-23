function [X,Y,Z]=G2C(phi,lambda,h)
%PURPOSE
%GEODETIC COORDINATES --> 3D CARTESIAN  COORDINATES.
%INPUTS:
%       fi,lambda,h : Station geodetic Coordinate(in the format [9 57 34.4877])
%       ellipsoid   :  WGS84.
%OUTPUTS:
%       X,Y,Z       : CARTESIAN  COORDINATES. 
% Mehran ghandehary
% 2008

%  WGS84   a = 6378137.000000 ; b = 6356752.314245; f= 1/298.257223563; 
a = 6378137.000000 ;      
b = 6356752.314245; 
f= 1/298.257223563;
b = phi(1)+phi(2)/60+phi(3)/3600;
b = b*pi/180;
l = lambda(1)+lambda(2)/60+lambda(3)/3600;
l = l*pi/180;
ex2 = (2-f)*f/((1-f)^2);
c = a*sqrt(1+ex2);
N = c/sqrt(1+ex2*cos(b)^2);
X = (N+h)*cos(b)*cos(l);
Y = (N+h)*cos(b)*sin(l);
Z = ((1-f)^2*N+h)*sin(b);


