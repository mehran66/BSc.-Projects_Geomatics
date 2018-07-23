
 function [Fi,Lambda,h]=xyz2filh2(X,Y,Z)
  
%PURPOSE
% 3D CARTESIAN  COORDINATES  --> GEODETIC COORDINATES
%INPUTS:
%       X,Y,Z       : CARTESIAN  COORDINATES. 
%       ellipsoid   : WGS84.
%OUTPUTS:
%       Fi,Lambda,h : Station geodetic Coordinate,

% Mehran ghandehary
% 2008

%  WGS84   a = 6378137.000000 ; b = 6356752.314245; f= 1/298.257223563; 

 a = 6378137.000000 ;      
 b = 6356752.314245; 
 f= 1/298.257223563;
  %h is wrong for X=0,Y=0;
  %h is wrong for X=0,Y=0;
 if(X==0&&Y==0) 
     if Z>=0
         h=Z-b;
         Fi=90;
     end
     if Z<0
         h=-Z-b;
         Fi=-90;
     end
     Lambda=0/0;
 end
 if(X~=0||Y~=0)
 syms xx;
p=sqrt(X^2+Y^2);
  e=sqrt((a^2-b^2)/a^2);
  fi(1)=atan(Z/(p*(1-e^2)));
  N(1)=a/sqrt(1-(e^2*(sin(fi(1)))^2));
  if(rad2deg(fi(1))<=45)
       h(1)=(p/cos(fi(1))-N(1));
  end
  if(rad2deg(fi(1))>45)
      h(1)=[Z/sin(fi(1))] - N(1)*(1 - e^2);
end       
 %Fi is derived from a qudratic form
 s=eval(solve('(p^2)*(xx^4)-(2*p*Z*(xx^3))+((Z^2)+(((p^2)-(a^2)*(e^4))/(1-e^2)))*(xx^2)-((2*p*Z)/(1-e^2))*(xx)+((Z^2)/(1-e^2))=0',xx));
 j=1;
 for i=1:4
     if abs(imag(s(i)))<0.001
         Fi1(j)=rad2deg(atan(real(s(i))));
         j=j+1;
     end
 end
 if j==1
     Fi=fi(1)*180/pi;
 end
 if j~=1
 for i=1:j-1
     l(i)=Fi1(i)-fi(1)*180/pi;
 end
 Fi=min(l)+fi(1)*180/pi;
 end
 
 Lambda=2*atan(Y/(X+sqrt(X^2+Y^2)))*180/pi; 
 end
 
 
  %correct Fi      
      if(Z>=0)
           if(Fi<=0)
               Fi=-Fi;
           end
       end
       if(Z<0)
           if(Fi>=0)
               Fi=-Fi;
           end
       end


 