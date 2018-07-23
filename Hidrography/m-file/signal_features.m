function [E,Ts,S,F,Fi,Lambda,H]=signal_features(ping)
%purpus :
%        Data Analysis
%Input :
%        one ping (ping is a vector of observation)
%Output
%       Total energy ---> E
%       Timespread ---> Ts
%       Skewness ---> S
%       flatness ---> F
%       Latitude ---> Fi
%       Longitude ---> Lambda
%       Depth ---> H

g=ping(15:end);
N=length(ping);
t=linspace(0,ping(6)*10^-6*N,N);
%Find the pick of ping
find1=find(g == max(g(150:end)));
find1=max(find1);
H=(t(find1)*ping(8))/2;
R=H;
for i=1:200
    j=find1-50;
    P(i)=10^(ping(j)/20);
    I(i)=P(i)^2;
    Is(i)=I(i)*(R^4)*exp(4*(ping(11)/1000000)*(R/8.686));
    I(i)=Is(i)/R;
    t_ref(i)=(10/H)*t(i);
end
delta_t=t_ref(2)-t_ref(1);
E=0;t0=0;temp1=0;temp2=0;temp3=0;
for i=1:100
    E=E+I(i)*delta_t;
end
for i=1:200
    t0=t0+I(i)*t_ref(i)*delta_t;
end
t0=t0/E;
for i=1:200
    temp1=temp1+I(i)*(t_ref(i)-t0)^2*delta_t;
end
Ts=sqrt(4/E*temp1);
for i=1:200
    temp2=temp2+I(i)*(t_ref(i)-t0)^3*delta_t;
end
S=(8/E*Ts^3)*temp2;
for i=1:200
    temp3=temp3+I(i)*(t_ref(i)-t0)^4*delta_t;
end
F=(16/E*Ts^4)*temp3;
Fi=ping(4)/50000000;
Lambda=ping(5)/50000000;









