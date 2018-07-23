 function [Fi,Lambda,h]=xyz2filhBowring(X,Y,Z)
  
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
 e2=((a^2-b^2)/a^2);
 ei2=((a^2-b^2)/b^2);
 e=sqrt(e2);
  fi(1)=atan(Z/(p*(1-e^2)));
  N=a/sqrt(1-(e^2*(sin(fi(1)))^2));
  if(rad2deg(fi(1))<=45)
       h=(p/cos(fi(1))-N);
  end
  if(rad2deg(fi(1))>45)
      h=[Z/sin(fi(1))] - N*(1 - e^2);
  end       
 B(1)=atan(a*Z/b*p);
 s=0;
 k=2;
 while abs(s)<10^-10 
     fi(k)=atan((Z+(ei2*b*(sin(B(k-1))^3)))/(p-(a*e2*(cos(B(k-1)))^3)));
     B(k)=atan((b/a)/tan(fi(k)));
     s=fi(k)-fi(k-1);
     k=k+1;
 end
 Fi=fi(k-1)*180/pi;
 if Fi>89.85
     Fi=-Fi;
 end
 Lambda=2*atan(Y/(X+sqrt(X^2+Y^2)))*180/pi;
  %h is wrong for X=0,Y=0
        %h is wrong for X=0,Y=0;
       if(X==0&&Y==0) 
           if Z>=0
               h=Z-b;
           end
           if Z<0
               h=-Z-b;
           end
       end
       
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