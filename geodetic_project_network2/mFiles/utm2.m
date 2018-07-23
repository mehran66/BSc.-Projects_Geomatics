function A=utm2(Fi1,Lambda1)
syms Fi Lambda
a = 6378137.000000;b = 6356752.314245;e=0.081819191;
e1=sqrt((a^2-b^2)/b^2);
N=a/(1-(e^2)*(sin(Fi)^2))^.5;
A0=1-(1/4*e^2)-(3/64*e^4)-(5/256*e^6)-(175/16384*e^8);
A2=3/8*((e^2)+(1/4*e^4)+(15/128*e^6)-(455/4096*e^8));
A4=15/256*((e^4)+(3/4*e^6)-(77/128*e^8));
A6=35/3072*((e^6)-(41/32*e^8));
A8=-315/131072*e^8;
% s=a*((Fi+3/4*Fi*e^2-Fi*e^2+45/64*Fi*e^4-3/4*Fi*e^4-45/64*Fi*e^6)+(-3/8*e^2*sin(2*Fi)-15/32*e^4*sin(2*Fi)+3/8*e^4*sin(2*Fi)+15/32*e^6*sin(2*Fi))+(15/256*e^4*sin(4*Fi)-15/256*e^6*sin(4*Fi)));
s=a*(A0*Fi-A2*sin(2*Fi)+A4*sin(4*Fi)-A6*sin(6*Fi)+A8*sin(8*Fi));
t=tan(Fi);
k=sqrt((e1^2)/(cos(Fi))^2);
x=N*(Lambda*cos(Fi)+(Lambda^3*(cos(Fi))^3/6)*(1-t^2+k^2)+(Lambda^5*(cos(Fi))^5/120)*(5-18*t^2+t^4+14*k^2-58*t^2*k^2+13*k^2+4*k^6-64*k^4*t^2-24*k^6*t^2)...
    +(Lambda^7*(cos(Fi))^7/5040)*(61-479*t^2+179*t^4-t^6));
y=N*((s/N)+(Lambda^2/2*sin(Fi)*cos(Fi))+(Lambda^4/24*sin(Fi)*(cos(Fi))^3*(5-t^2+9*k^2+4*k^4))...
    +(Lambda^6/720*sin(Fi)*(cos(Fi))^5*(61-58*t^2+t^4+270*k^2-330*t^2*k^2+445*k^4+324*k^6-680*k^4*t^2+88*k^8-600*k^6*t^2+192*k^8*t^2))...
    +(Lambda^8/40320*sin(Fi)*(cos(Fi))^7*(1385-311*t^2+543*t^4-t^6)));
x=.9996*x;y=.9996*y;
A=jacobian([x; y], [Fi Lambda]);
 Fi=Fi1;
 Lambda=Lambda1;
 A=eval(A);