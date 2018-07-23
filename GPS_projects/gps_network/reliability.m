clc;clear all;format long g;
%There are five point and 402 is a Fix point
syms x309 x311 x315 x401 x402 y309 y311 y315 y401 y402 z309 z311 z315 z401 z402 
%Convert Geodetic coordinate to Catesian
[X0_402,Y0_402,Z0_402]=G2C([47 22 45.13567],[9 40 13.25647],460.223);
[X0_309,Y0_309,Z0_309]=G2C([47 23 42.1315],[9 39 06.7501],454.6084);
[X0_315,Y0_315,Z0_315]=G2C([47 23 2.52377],[9 38 20.12157],461.3014);
[X0_311,Y0_311,Z0_311]=G2C([47 23 12.44956],[9 38 14.81397],454.8585);
[X0_401,Y0_401,Z0_401]=G2C([47 23 33.30053],[9 40 04.10243],456.5356);
X0=[X0_309 Y0_309 Z0_309 X0_311 Y0_311 Z0_311 X0_315 Y0_315 Z0_315 X0_401 Y0_401 Z0_401];
%Equation daltax,deltay,deltaz
K=[x309-x401 ;y309-y401;z309-z401; x311-x315; y311-y315;z311-z315;x401-x315; y401-y315;z401-z315; x311-x309; y311-y309;z311-z309;x315-x309;...
   y315-y309;z315-z309; x315-x402; y315-y402; z315-z402; x401-x402; y401-y402; z401-z402;x309-x402;y309-y402;z309-z402] ;
Kx=[x309 y309 z309 x311 y311 z311 x315 y315 z315 x401 y401 z401 x402 y402 z402];
A=jacobian(K,Kx);A=eval(A);
%Observation
l=[X0_309-X0_401 ;Y0_309-Y0_401;Z0_309-Z0_401; X0_311-X0_315; Y0_311-Y0_315;Z0_311-Z0_315;X0_401-X0_315; Y0_401-Y0_315;Z0_401-Z0_315; X0_311-X0_309; Y0_311-Y0_309;Z0_311-Z0_309;X0_315-X0_309;...
   Y0_315-Y0_309;Z0_315-Z0_309; X0_315-X0_402; Y0_315-Y0_402; Z0_315-Z0_402; X0_401-X0_402; Y0_401-Y0_402; Z0_401-Z0_402;X0_309-X0_402;Y0_309-Y0_402;Z0_309-Z0_402];
D=[1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 
    0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 
    0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 ];
N1=inv(A'*A+D'*D)-D'*inv(D*D'*D*D')*D;
n=5;
R1=eye(24,24)-(A*inv(A'*A+D'*D)*A');




%**************************************************************************


%There are five point and 402 is a Fix point
syms x309 x311 x315 x401 x402 y309 y311 y315 y401 y402 z309 z311 z315 z401 z402 
%Convert Geodetic coordinate to Catesian
[X0_402,Y0_402,Z0_402]=G2C([47 24 45.13567],[9 42 13.25647],460.223);
[X0_309,Y0_309,Z0_309]=G2C([47 22 42.1315],[9 39 06.7501],454.6084);
[X0_315,Y0_315,Z0_315]=G2C([47 21 2.52377],[9 40 20.12157],461.3014);
[X0_311,Y0_311,Z0_311]=G2C([47 21 12.44956],[9 39 14.81397],454.8585);
[X0_401,Y0_401,Z0_401]=G2C([47 20 33.30053],[9 38 04.10243],456.5356);
X0=[X0_309 Y0_309 Z0_309 X0_311 Y0_311 Z0_311 X0_315 Y0_315 Z0_315 X0_401 Y0_401 Z0_401];
%Equation daltax,deltay,deltaz
K=[x309-x401 ;y309-y401;z309-z401; x311-x315; y311-y315;z311-z315;x401-x315; y401-y315;z401-z315; x311-x309; y311-y309;z311-z309;x315-x309;...
   y315-y309;z315-z309; x315-x402; y315-y402; z315-z402; x401-x402; y401-y402; z401-z402;x309-x402;y309-y402;z309-z402] ;
Kx=[x309 y309 z309 x311 y311 z311 x315 y315 z315 x401 y401 z401 x402 y402 z402];
A=jacobian(K,Kx);A=eval(A);
%Observation
l=[X0_309-X0_401 ;Y0_309-Y0_401;Z0_309-Z0_401; X0_311-X0_315; Y0_311-Y0_315;Z0_311-Z0_315;X0_401-X0_315; Y0_401-Y0_315;Z0_401-Z0_315; X0_311-X0_309; Y0_311-Y0_309;Z0_311-Z0_309;X0_315-X0_309;...
   Y0_315-Y0_309;Z0_315-Z0_309; X0_315-X0_402; Y0_315-Y0_402; Z0_315-Z0_402; X0_401-X0_402; Y0_401-Y0_402; Z0_401-Z0_402;X0_309-X0_402;Y0_309-Y0_402;Z0_309-Z0_402];
D=[1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 
    0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 
    0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 ];
N2=inv(A'*A+D'*D)-D'*inv(D*D'*D*D')*D;
n=5;
R2=eye(24,24)-(A*inv(A'*A+D'*D)*A');



R1-R2;
N1-N2;