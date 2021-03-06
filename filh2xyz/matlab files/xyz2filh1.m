 
 function [Fi,Lambda,h]=xyz2filh1(X,Y,Z)
  
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
  p=sqrt(X^2+Y^2);
  e=sqrt((a^2-b^2)/a^2);
  %computation h
  fi(1)=atan(Z/(p*(1-e^2)));
  N(1)=a/sqrt(1-(e^2*(sin(fi(1)))^2));
  if(rad2deg(fi(1))<=45)
       h(1)=(p/cos(fi(1))-N(1));
  end
  if(rad2deg(fi(1))>45)
      h(1)=[Z/sin(fi(1))] - N(1)*(1 - e^2);
  end       
  s=10^-20;
  t=10^-50;
  k=2;
  %Fi get from a itterative solutions.
  while abs(s)<10^-10 && abs(t)<a*abs(s)
      N(k)=a/sqrt(1-(e^2*(sin(fi(k-1)))^2));
      h(k)=(p/cos(fi(k-1))-N(k));
      fi(k)=atan(Z/p*(1-(e^2*N(k)/(N(k)+h(k)))))
      s=fi(k)-fi(k-1);
      t=h(k)-h(k-1);
      k=k+1;
  end
  Lambda=2*atan(Y/(X+sqrt(X^2+Y^2)))*180/pi;
  Fi=fi(k-1)*180/pi;
   h=h(1);
  %h is wrong for X=0,Y=0;
  %Fi is wrong for X=0,Y=0;
   if(X==0&&Y==0) 
       if Z>=0
           h=Z-b;
       end
       if Z<0
           h=-Z-b;
       end
       Fi=-Fi;
   end
%correct Fi      
  if(Z>=0)
       if(Fi<0)
           Fi=-Fi;
       end
   end
   if(Z<0)
       if(Fi>0)
           Fi=-Fi;
       end
   end
       
     
      
      
          
          
          
          