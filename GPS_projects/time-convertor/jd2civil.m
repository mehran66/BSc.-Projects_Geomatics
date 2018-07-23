function [Year Month Day Hour Minute Second] = jd2civil(x)


%     PURPOSE:
%                CONVERT JULIAN DAY NUMBER TO CIVIL DATE
%       INPUT:
%                JULIAN DAY NUMBER 
%      OUTPUT:
%                GREGORIAN DATE ( CIVIL DATE )[Year Month Day Hour Minute Second]      

x = x + 0.5;
Z = floor(x);
F = mod(x,Z);

if Z<2299161
    A = Z;
else
    alpha = floor( (Z-1867216.25)/36524.25 );
    A = Z + 1 + alpha - floor(alpha/4);
end

B = A + 1524;
C = floor( (B-122.1)/365.25 );
D = floor( 365.25*C );
E = floor( (B-D)/30.6001 );
Dayy = B - D - floor( 30.6001*E ) + F;

if E==14 || E==15
    Month = E - 13;
end

if E<14
    Month = E - 1;
end

if Month==1 || Month==2
    Year = C - 4715;
end

if Month>2
    Year = C - 4716;
end

Day = floor( Dayy );
Hour = floor( mod( Dayy,Day )*24 );
Minute = floor( ( ( mod( Dayy,Day )*24 ) - Hour )*60 );
Second = ([( ( mod( Dayy,Day )*24 ) - Hour )*60] - Minute)*60;

end
