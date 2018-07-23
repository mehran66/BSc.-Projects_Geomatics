clear all;clc;
format short;
k=11;
fi=(0:k)/(k+1)*2*pi;
xC=cos(fi)*200+200;
yC=sin(fi)*200+135;
xC=[xC 200];
yC=[yC 135];
j=1;
for i=1:length(xC)
    x(j)=xC(i);
    x(j+1)=yC(i);
    j=j+2;
end
n=k+2;
A(1:(n*(n-1)/2),1:2*n)=[0];
temp1=1;
for i=1:n
     for j=i+1:n
        l(temp1)=sqrt((xC(j)-xC(i))^2+(yC(j)-yC(i))^2);
        A(temp1,2*i-1)=-(xC(j)-xC(i))/l(temp1);
        A(temp1,2*i)=-(yC(j)-yC(i))/l(temp1);
        A(temp1,2*j-1)=(xC(j)-xC(i))/l(temp1);
        A(temp1,2*j)=(yC(j)-yC(i))/l(temp1);
        temp1=temp1+1;
    end
end
for i=1:n
    H(1,2*i-1)=1;
    H(1,2*i)=0;
    H(2,2*i-1)=0;
    H(2,2*i)=1;
    H(3,2*i-1)=yC(i);
    H(3,2*i)=-xC(i);
end
    D(3,1:2*n)=[0];
    D(1,1)=1;
    D(2,2)=1;
    D(3,23)=-(yC(13)-yC(12))/l(temp1-1)^2;
    D(3,24)=(xC(13)-xC(12))/l(temp1-1)^2;
    D(3,25)=(yC(13)-yC(12))/l(temp1-1)^2;
    D(3,26)=-(xC(13)-xC(12))/l(temp1-1)^2;
     N1=inv((A'*A)+D'*D)-H'*inv(H*D'*D*H')*H;
     
    A(:,1:2)=[];
D(:,1:2)=[];
H(:,1:2)=[];
x(1:2)=[];
    N=inv((A'*A)+D'*D);

    w=randn(78,1);
    L=w+l';
    u=A'*w;
    deltax_hat=N*u
    x_hat=x'+deltax_hat
        N=N1;
        x_hat=[xC(1);yC(1);x_hat];
        
        temp=1;
        for i=3:2:(n)*2-1
    A=[N(i,i) N(i,i+1);N(i+1,i) N(i+1,i+1)];
   %SUPPORT Plot of support function and pertinent confidence
%     	ellipse for a given 2 by 2 covariance matrix A

%Kai Borre 
%Copyright (c) by Kai Borre
%$Revision: 1.0 $  $Date: 1997/09/26  $

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

title(['Point number',num2str(temp+1)])
temp=temp+1;
        end