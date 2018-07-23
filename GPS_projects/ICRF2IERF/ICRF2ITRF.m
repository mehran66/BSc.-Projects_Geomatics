function [X Y Z]=ICRF2ITRF(Xc,Yc,Zc,kisi,teta,z,delta_epsilon,delta_sai,GAST,xp,yp)
 %purpose:
%            convert celectial refrence fram to terrestrial refrence fram 
%inputs:
%       Xc,Yc,Zc        :  celectial coordine system
%       kisi,teta,z     :  precesion parameters(degree)
%       delta_epsilon,delta_sai   :  nutation parameters(degree)
%       GAST            :(degree)
%       xp,yp           :   pole coordinate

%outputs:
%        X.Y,Z          :   terrestrial coordine system
epsilon=23.5;
R_precesion=rot(-z,3)*rot(teta,2)*rot(-kisi,3);
R_nutation=rot(epsilon-delta_epsilon,1)*rot(delta_sai,3)*rot(epsilon,1);
R_GAST=rot(GAST,3);
R_pole=rot(-xp,2)*rot(-yp,1);
ans=R_pole*R_GAST*R_nutation*R_precesion*[Xc Yc Zc]';
X=ans(1);Y=ans(2);Z=ans(3);
