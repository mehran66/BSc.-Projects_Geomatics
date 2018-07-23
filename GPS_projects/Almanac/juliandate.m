function y = juliandate(x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     This function convert Gregorian calendar date to Julian Day Number
%
%     PURPOSE:
%                CONVERT CIVIL DATE TO JULIAN DAY NUMBER
%       INPUT:
%                CIVIL DATE ( GREGORIAN DATE )
%      OUTPUT:
%                JULIAN DAY NUMBER
%
%
% ----------------                  HINT                   ----------------
%
%       Valid for all Gregorian calendar dates after November 23, 4713
%
% Input x must be in such format:
%
%          [Year Month Day Hour Minute Second] or [Year Month Day]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format long g;
jdate = datenum([1582 10 4 23 59 59.9999]);
xx = datenum(x);

if [1,6]==size(x)

    h = x(1,4);
    m = x(1,5);
    s = x(1,6);
    k = ( h + ( m+(s/60) )/60 )/24;
    x(1,3) = x(1,3)+k;
    Y = x(1,1);
    M = x(1,2);
    D = x(1,3);

    if M>2
        Y;
        M;
    else
        Y=Y-1;
        M=M+12;
    end

    A = floor(Y/100);

    if  xx<=jdate
        B = 0;
    else
        B = 2-A+floor(A/4);
    end

    jd = floor( 365.25 * (Y + 4716 )) + floor( 30.6001 * (M+1)) + D + B - 1524.5;
    y = jd;

elseif [1,3]==size(x)

    x;
    Y = x(1,1);
    M = x(1,2);
    D = x(1,3);

    if M>2
        Y;
        M;
    else
        Y = Y - 1;
        M = M + 12;
    end

    A = floor( Y/100 );

    if  xx<=jdate
        B = 0;
    else
        B = 2-A+floor(A/4);
    end

    jd = floor( 365.25 * (Y + 4716 )) + floor( 30.6001 * (M+1)) + D + B - 1524.5;
    y = jd;

else

    disp( 'Wrong date in put,Pay attention' );

end
end