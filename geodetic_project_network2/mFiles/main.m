clc;clear all;format short g
disp('--------------------------------------------------------------------')
disp('        |                                       |                   ')
disp('        |project by :      mehran ghandehary    |                   ')
disp('        |no : 851921326                         |                   ')
disp('        |********Surveying Engineering**********|                  ')
disp('        |********Isfahan University*************|                   ')
%-------------------Information-----------------------
%Geodesy 2 computatation
%Third project-------->Adjustment a Geodetic network on the Ellipsoid
% WGS84    a = 6378137.000000 ; b = 6356752.314245;  
%There are six point in the network that 2 point are known
%coordinate of known point
%Point   Lattitude     StDev.[m]   Longitude       StDev.[m]
%1    N 30 00 0.00019  ±0.005      W 90 00 0.00013 ±0.005
%4    N 30 01 47.00550 ±0.006      W 90 14 9.00022 ±0.006
%Approximate coordinate of unknown point
% Point Approx. Latitude Approx. Longitude
% 5     N 30 11 47       W 90 14 58       
% 6     N 30 23 40       W 90 15 57       
% 2     N 30 10 54       W 89 58 58
% 3     N 30 25 40       W 90 00 54
Fi=[30 00 0.00019;30 10 54;30 25 40 ;30 01 47.00550;30 11 47; 30 23 40];
Lambda=[90 00 0.00013;89 58 58;90 00 54;90 14 9.00022;90 14 58;90 15 57];
Fi=deg2rad(dms2degrees(Fi));Lambda=-deg2rad(dms2degrees(Lambda));
Fi1=Fi(1);Fi2=Fi(2);Fi3=Fi(3);Fi4=Fi(4);Fi5=Fi(5);Fi6=Fi(6);
Lambda1=Lambda(1);Lambda2=Lambda(2);Lambda3=Lambda(3);Lambda4=Lambda(4);Lambda5=Lambda(5);Lambda6=Lambda(6);
j=1;
for i=1:2:12
    x(i)=Fi(j);
    x(i+1)=Lambda(j);
    j=j+1;
end
x=x';
x1=x;
%There are fourteen observation(five distance,3 Azimutes,6 Angle)
% From To Azimuth      St.Dev.[sec]
%  3   1  178 15 8.06  ±1.0
%  3   4  205 46 47.50 ±1.0
%  5   4  175 51 33.33 ±1.0
Az=[178 15 8.06;205 46 47.50;175 51 33.33];
Az_o=deg2rad(dms2degrees(Az));
% From To Distance[m] StDev.
%  1   2  20204.068   10mm+3ppm
%  1   3  47442.343   10mm+3ppm
%  2   4  29617.434   10mm+3ppm
%  3   2  27454.890   10mm+3ppm
%  6   5  22011.770   10mm+3ppm
s_o=[20204.068;27454.890;22011.770];
% From Occupied To Angle          St.Dev.[sec]
%  2     1      4  273 39 55.80   ±1
%  1     2      3  168 56 24.80   ±1
%  1     4      5  257 41 06.40   ±1
%  3     6      5  94 35 13.50    ±1
%  1     5      2  321 32 4.11    ±1
%  6     5      2  97 44 27.96    ±1
Angle=[273 39 55.80;168 56 24.80;257 41 06.40;94 35 13.50;321 32 4.11;97 44 27.96];
Angle_o=deg2rad(dms2degrees(Angle));
%--------------------First step--------------------
%Adjustment network with weighted parameters method
%Organizing matrix A(14,12)
e=0.081819191;
deltax_hat=5;
while norm(deltax_hat)>10^-9 
Fi1=x(1);Fi2=x(3);Fi3=x(5);Fi4=x(7);Fi5=x(9);Fi6=x(11);
Lambda1=x(2);Lambda2=x(4);Lambda3=x(6);Lambda4=x(8);Lambda5=x(10);Lambda6=x(12);
A(12,12)=0;
k=1;
% %line 1
A(k,1)=cofficient('a',Fi1,Lambda1,Fi2,Lambda2);
A(k,2)=cofficient('b',Fi1,Lambda1,Fi2,Lambda2);
A(k,3)=cofficient('c',Fi1,Lambda1,Fi2,Lambda2);
A(k,4)=cofficient('d',Fi1,Lambda1,Fi2,Lambda2);
k=k+1;
%line 2
% A(k,1)=cofficient('a',Fi1,Lambda1,Fi3,Lambda3);
% A(k,2)=cofficient('b',Fi1,Lambda1,Fi3,Lambda3);
% A(k,5)=cofficient('c',Fi1,Lambda1,Fi3,Lambda3);
% A(k,6)=cofficient('d',Fi1,Lambda1,Fi3,Lambda3);
% k=k+1;
%line 3
% A(k,3)=cofficient('a',Fi2,Lambda2,Fi4,Lambda4);
% A(k,4)=cofficient('b',Fi2,Lambda2,Fi4,Lambda4);
% A(k,7)=cofficient('c',Fi2,Lambda2,Fi4,Lambda4);
% A(k,8)=cofficient('d',Fi2,Lambda2,Fi4,Lambda4);
% k=k+1;
%line 4
A(k,3)=cofficient('c',Fi3,Lambda3,Fi2,Lambda2);
A(k,4)=cofficient('d',Fi3,Lambda3,Fi2,Lambda2);
A(k,5)=cofficient('a',Fi3,Lambda3,Fi2,Lambda2);
A(k,6)=cofficient('b',Fi3,Lambda3,Fi2,Lambda2);
k=k+1;
% % line 5
A(k,9)=cofficient('c',Fi6,Lambda6,Fi5,Lambda5);
A(k,10)=cofficient('d',Fi6,Lambda6,Fi5,Lambda5);
A(k,11)=cofficient('a',Fi6,Lambda6,Fi5,Lambda5);
A(k,12)=cofficient('b',Fi6,Lambda6,Fi5,Lambda5);
k=k+1;
%line 6
A(k,1)=cofficient('g',Fi3,Lambda3,Fi1,Lambda1);
A(k,2)=-cofficient('f',Fi3,Lambda3,Fi1,Lambda1);
A(k,5)=cofficient('e',Fi3,Lambda3,Fi1,Lambda1);
A(k,6)=cofficient('f',Fi3,Lambda3,Fi1,Lambda1);
k=k+1;
%line 7
A(k,5)=cofficient('e',Fi3,Lambda3,Fi4,Lambda4);
A(k,6)=cofficient('f',Fi3,Lambda3,Fi4,Lambda4);
A(k,7)=cofficient('g',Fi3,Lambda3,Fi4,Lambda4);
A(k,8)=-cofficient('f',Fi3,Lambda3,Fi4,Lambda4);
k=k+1;
%line 8
A(k,7)=cofficient('g',Fi5,Lambda5,Fi4,Lambda4);
A(k,8)=-cofficient('f',Fi5,Lambda5,Fi4,Lambda4);
A(k,9)=cofficient('e',Fi5,Lambda5,Fi4,Lambda4);
A(k,10)=cofficient('f',Fi5,Lambda5,Fi4,Lambda4);
k=k+1;
%line 9
A(k,1)=cofficient('e',Fi1,Lambda1,Fi4,Lambda4)-cofficient('e',Fi1,Lambda1,Fi2,Lambda2);
A(k,2)=cofficient('f',Fi1,Lambda1,Fi4,Lambda4)-cofficient('f',Fi1,Lambda1,Fi2,Lambda2);
A(k,3)=-cofficient('g',Fi1,Lambda1,Fi2,Lambda2);
A(k,4)=cofficient('f',Fi1,Lambda1,Fi2,Lambda2);
A(k,7)=cofficient('g',Fi1,Lambda1,Fi4,Lambda4);
A(k,8)=-cofficient('f',Fi1,Lambda1,Fi4,Lambda4);
k=k+1;
%line 10
A(k,1)=-cofficient('g',Fi2,Lambda2,Fi1,Lambda1);
A(k,2)=cofficient('f',Fi2,Lambda2,Fi1,Lambda1);
A(k,3)=cofficient('e',Fi2,Lambda2,Fi3,Lambda3)-cofficient('e',Fi2,Lambda2,Fi1,Lambda1);
A(k,4)=cofficient('f',Fi2,Lambda2,Fi3,Lambda3)-cofficient('f',Fi2,Lambda2,Fi1,Lambda1);
A(k,5)=cofficient('g',Fi2,Lambda2,Fi3,Lambda3);
A(k,6)=-cofficient('f',Fi2,Lambda2,Fi3,Lambda3);
k=k+1;
%line 11
A(k,1)=-cofficient('g',Fi4,Lambda4,Fi1,Lambda1);
A(k,2)=cofficient('f',Fi4,Lambda2,Fi1,Lambda1);
A(k,7)=cofficient('e',Fi4,Lambda4,Fi5,Lambda5)-cofficient('e',Fi4,Lambda4,Fi1,Lambda1);
A(k,8)=cofficient('f',Fi4,Lambda4,Fi5,Lambda5)-cofficient('f',Fi4,Lambda4,Fi1,Lambda1);
A(k,9)=cofficient('g',Fi4,Lambda4,Fi5,Lambda5);
A(k,10)=-cofficient('f',Fi4,Lambda4,Fi5,Lambda5);
k=k+1;
%line 12
A(k,5)=-cofficient('g',Fi6,Lambda6,Fi3,Lambda3);
A(k,6)=cofficient('f',Fi6,Lambda6,Fi3,Lambda3);
A(k,9)=cofficient('g',Fi6,Lambda6,Fi5,Lambda5);
A(k,10)=-cofficient('f',Fi6,Lambda6,Fi5,Lambda5);
A(k,11)=cofficient('e',Fi6,Lambda6,Fi5,Lambda5)-cofficient('e',Fi6,Lambda6,Fi3,Lambda3);
A(k,12)=cofficient('f',Fi6,Lambda6,Fi5,Lambda5)-cofficient('f',Fi6,Lambda6,Fi3,Lambda3);
k=k+1;
%line 13
A(k,1)=-cofficient('g',Fi5,Lambda5,Fi1,Lambda1);
A(k,2)=cofficient('f',Fi5,Lambda5,Fi1,Lambda1);
A(k,3)=cofficient('g',Fi5,Lambda5,Fi2,Lambda2);
A(k,4)=-cofficient('f',Fi5,Lambda5,Fi2,Lambda2);
A(k,9)=cofficient('e',Fi5,Lambda5,Fi2,Lambda2)-cofficient('e',Fi5,Lambda5,Fi1,Lambda1);
A(k,10)=cofficient('f',Fi5,Lambda5,Fi2,Lambda2)-cofficient('f',Fi5,Lambda5,Fi1,Lambda1);
k=k+1;
%line 14
A(k,3)=cofficient('g',Fi5,Lambda5,Fi2,Lambda2);
A(k,4)=-cofficient('f',Fi5,Lambda5,Fi2,Lambda2);
A(k,9)=cofficient('e',Fi5,Lambda5,Fi2,Lambda2)-cofficient('e',Fi5,Lambda5,Fi6,Lambda6);
A(k,10)=cofficient('f',Fi5,Lambda5,Fi2,Lambda2)-cofficient('f',Fi5,Lambda5,Fi6,Lambda6);
A(k,11)=-cofficient('g',Fi5,Lambda5,Fi6,Lambda6);
A(k,12)=cofficient('f',Fi5,Lambda5,Fi6,Lambda6);
%Organizing matrix Ax(4,12)
% Ax(4,12)=0;
% Ax(1,1)=1;Ax(2,2)=1;
% % clx=[.005,.005];
% Ax(3,7)=1;Ax(4,8)=1;
% clx=[.005/6400000,.005/6400000,.006/6400000,.006/6400000];
% clx=diag(clx);
% px=inv(clx^2);
Ax(4,12)=0;
Ax(1,1)=1;Ax(2,2)=1;
% clx=[.005/6400000,.005/6400000];
Ax(3,7)=1;Ax(4,8)=1;
clx=[.005/6400000,.005/6400000,.006/6400000,.006/6400000];
clx=diag(clx);
px=inv(clx^2);
[alfa12,s_cc1]=Robbins(Fi1,Lambda1,Fi2,Lambda2);s_c(1)=s_cc1;
% [alfa12,s_cc2]=Robbins(Fi1,Lambda1,Fi3,Lambda3);s_c(2)=s_cc2;
% [alfa12,s_cc3]=Robbins(Fi2,Lambda2,Fi4,Lambda4);s_c(3)=s_cc3;
[alfa12,s_cc4]=Robbins(Fi3,Lambda3,Fi2,Lambda2);s_c(2)=s_cc4;
[alfa12,s_cc5]=Robbins(Fi6,Lambda6,Fi5,Lambda5);s_c(3)=s_cc5;
[alfa12,s_cc6]=Robbins(Fi3,Lambda3,Fi1,Lambda1);Az_c(1)=alfa12;
[alfa12,s_cc7]=Robbins(Fi3,Lambda3,Fi4,Lambda4);Az_c(2)=alfa12;
[alfa12,s_cc8]=Robbins(Fi5,Lambda5,Fi4,Lambda4);Az_c(3)=alfa12;
Angle_c(1)=Robbins(Fi1,Lambda1,Fi4,Lambda4)-Robbins(Fi1,Lambda1,Fi2,Lambda2);
Angle_c(2)=Robbins(Fi2,Lambda2,Fi3,Lambda3)-Robbins(Fi2,Lambda2,Fi1,Lambda1);
Angle_c(3)=Robbins(Fi4,Lambda4,Fi5,Lambda5)-Robbins(Fi4,Lambda4,Fi1,Lambda1);
Angle_c(4)=Robbins(Fi6,Lambda6,Fi5,Lambda5)-Robbins(Fi6,Lambda6,Fi3,Lambda3);
Angle_c(5)=(Robbins(Fi5,Lambda5,Fi2,Lambda2)-Robbins(Fi5,Lambda5,Fi1,Lambda1))+2*pi;
Angle_c(6)=(Robbins(Fi5,Lambda5,Fi2,Lambda2)+(2*pi-Robbins(Fi5,Lambda5,Fi6,Lambda6)));
obs=[s_o;Az_o;Angle_o];
comp=[s_c,Az_c,Angle_c]';
W=(comp-obs);
%Organizing matrix p(weigt)
% cl=[70.6122,152.327,98.8522,92.3646,76.0353,4.848*10^(-6),4.848*10^(-6),4.848*10^(-6),4.848*10^(-6),4.848*10^(-6),4.848*10^(-6),4.848*10^(-6),4.848*10^(-6),4.848*10^(-6)];
cl=[70.6122*.001,92.3646*.001,76.0353*.001,1/206265,1/206265,1/206265,1/206265,1/206265,1/206265,1/206265,1/206265,1/206265];
cl=diag(cl);
% p1=[14.9422508727314,8.73301892655232,12.8867968226999,651288130237599, 651288130237599];
% p2=[651288130237599,651288130237599,651288130237599,651288130237599,651288130237599,651288130237599,651288130237599];
% p=[p1,p2];
% p=diag(p);
p=inv(cl^2);
A1=A'*p*A+Ax'*px*Ax;
deltax_hat=-inv(A1)*(A'*p*W);
norm(deltax_hat);
x_hat=x+deltax_hat
x=x_hat;
v_hat=A*deltax_hat+W
v_hatx=Ax*deltax_hat;
sigma02_hat=((v_hat'*p*v_hat)+(v_hatx'*px*v_hatx))/4
end
Cx_hat=sigma02_hat*inv(A1)
Cl_hat=A*Cx_hat*A';
Cv_hat=(cl-Cl_hat);
khi2_1=11.14;
khi2_2=.48;
k=0;
%teste sigma02_hat
if 6*sigma02_hat/khi2_1<=1&&6*sigma02_hat/khi2_2>=1
    k=1
end
%teste Barda
if k==0
    m=outliers(v_hat,Cv_hat);
end
 j=1;
%utm 
for i=1:6
    [X(i),Y(i)]=utm(x(j),x(j+1));
    j=j+2;
end
    B(12,12)=0;
for j=1:2:12
    Fi=x(j);Lambda=x(j+1);
    B1=utm2(Fi,Lambda);
    B(j,j)=B1(1,1);B(j,j+1)=B1(1,2);B(j+1,j)=B1(2,1);B(j+1,j+1)=B1(2,2);
end
Cx_hat_utm=B*Cx_hat*B'

 plot(X,Y,'^','MarkerFaceColor','g','MarkerSize',30);        hold on;  
for i=1:6
    text(X(i),Y(i),num2str(i),'BackgroundColor',[.7 .9 .7]);
end
N=Cx_hat_utm;j=1;temp=1;
for i=1:2:11
    A=[N(i,i) N(i,i+1);N(i+1,i) N(i+1,i+1)];
%    SUPPORT Plot of support function and pertinent confidence
delete support.eps
[m,n] = size(A);
if m ~= 2 | n ~= 2
   error('Wrong dimension of matrix');
end
[v,d] = eig(A);
if d(1,1) <= 0 | d(2,2) <= 0
   error('The input matrix is no covariance matrix'); 
end;

% Calculations for confidence ellipse
[lambda,k] = sort(diag(d));
v = v(:,k);
if any(any(v)) == 1
   alpha = atan2(v(2,2),v(1,2))+pi/2;
else 
   alpha = 0;
end
rot = [cos(alpha) sin(alpha);-sin(alpha) cos(alpha)];
t = linspace(0,2*pi,100);
a = sqrt(lambda(2))
b = sqrt(lambda(1));
pl = [a*cos(t);b*sin(t)];
for t = 1:100
   current = rot*pl(:,t); curve(1:2,t) = current; 
end

% Calculations for support function
phi = linspace(0,2*pi,100);
support = sqrt(A(1,1)*(cos(phi)).^2 + A(2,1)*sin(2*phi)...
   + A(2,2)*(sin(phi)).^2);

% The 1-axis is oriented upwards and the 2-axis towards the right.
% In the polar plot we add pi/2 and in the cartesian plot
% interchanged the 1 and 2 columns of curve
h = figure(temp);
hold on
axis([-1.5*a 1.5*a -1.5*a 1.5*a])
axis equal

polar(phi,support,'b-')
axis(axis)
plot(curve(2,1:100),curve(1,1:100),'r--')

% hold off
% print support -deps
%%%%%%%% end support.m %%%%%%%%%%%%%%%%%%%

title(['Point number',num2str(temp)])
temp=temp+1;
end
        



