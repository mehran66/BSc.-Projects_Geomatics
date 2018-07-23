%%
clc;clear all;format long g;
disp('--------------------------------------------------------------------')
disp('        |                                       |                   ')
disp('        |project by :      mehran ghandehary    |                   ')
disp('        |no : 851921326                         |                   ')
disp('        |********Surveying Engineering**********|                  ')
disp('        |********Isfahan University*************|                   ')


% MJD=Modified Julian Date=Julian Date-2400000.5 days
% MGD=52974 for 2003.Des.01
% UT1-UTC=-0.3892-0.00028(MJD-52961)-(UT2-UT1);
% UT2-UT1=0.022*sin(2*PI*T)-0.12*cos(2*PI*T)-0.006*sin(4*PI*T)+0.007*cos(4*PI*T);
% % T=Besselian year
% T=2000-(51544.5-MJD)/(365.242189813);
% A=2*PI*(MJD-52956)/365.25;
% C=2*PI*(MJD-52956)/435;
%**************************************************************************
%%
MJD=53005:1:(1827+53005);
for i=1:1828
A(i)=2*pi*(MJD(i)-52956)/365.25;
C(i)=2*pi*(MJD(i)-52956)/435;
x(i)=.0621+0.0184*cos(A(i))-0.0912*sin(A(i))+0.1036*cos(C(i))-0.0693*sin(C(i));
y(i)=0.3437-0.0761*cos(A(i))-0.0233*sin(A(i))-0.0693*cos(C(i))-0.1036*sin(C(i));
end
plot(x,y)
xlabel('Xp')
ylabel('Yp')
title('Polar Variation')
%**************************************************************************
%%
MJD=54832:1:(54832+364);
for i=1:365
    T(i)=2000-((51544.5-MJD(i))/(365.242189813));
    DUT2(i)=0.022*sin(2*pi*T(i))-0.012*cos(2*pi*T(i))-0.006*sin(4*pi*T(i))+0.007*cos(4*pi*T(i));
    DUT1(i)=-0.3892-(0.00028*(MJD(i)-52961))-(DUT2(i));
end
i=1:1:365;
plot(i,DUT1);
xlabel('Day in 2009 year')
ylabel('DUT1 (Second)')
title('DUT1 Variation')
%**************************************************************************