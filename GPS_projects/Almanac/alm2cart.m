function s = alm2cart(x,y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This function calculate global cartesian coordinate of satellites
%   from almanac file
%
%     PURPOSE:
%                CALCULATE CARTESIAN COORDINATE OF SATELLITES
%       INPUT:
%                ALMANAC TEXT FILE , DATE AND TIME OF DESIRE
%      OUTPUT:
%                CARTESIAN COORDINATE OF SATELLITE
%
%
% ----------------                  HINT                   ----------------
%
% Input x must be in such form ( x = '*.txt')
% Input y must be in such form ( y = [ YEAR MONTH DAY HOUR MINUTE SECOND])
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format long g;

%-------------------------------- Constant --------------------------------

GM = 3.986004418*10^14;% ------ Gravitational constant of the earth (m3/s2)
Omegaie = 7.2921151467064*10^-5;% Nominal angular velocity of Earth (rad/s)

%-------------------------- Creat Almanac Matrice -------------------------

m = read_YUMA(x)

%------------------- Calculate GPS time from import date and time ---------

gtime = gpstime(y);


%                  Correction of GPS second cause difference of
%                        GPS Week Number and Week of YUMA

tgps = gtime(1,3) + (gtime(1,1)-m(13,1))*7*(4*60-4.09);


%--------------------------------------------------------------------------

for i=1:31

    toe(1,i) = m(4,i) + m(11,i);
    n(1,i) = sqrt( GM/(m(7,i)^6) );

    if m(10,i)<0
        m(10,i) = m(10,i)+2*pi;
    end

    M(1,i) = m(10,i) + n(1,i)*( tgps-toe(1,i) );
    E(1,i) = newton(M(1,i),m(3,i));
    r(1,i) = m(7,i)^2 * (1 - m(3,i)*cos(E(1,i)));
    no(1,i) = atan ( ( sqrt(1 - m(3,i)^2)*sin(E(1,i)) ) / ( cos(E(1,i)) - m(3,i) ) );
    phi(1,i) = no(1,i) + m(9,i);

    if phi(1,i)<0
        phi(1,i) = phi(1,i) + 2*pi ;
    end

    omega(1,i) = m(8,i) + m(6,i)*( tgps-toe(1,i) ) - Omegaie*tgps;

    while omega(1,i)<0
        omega(1,i) = omega(1,i) + 2*pi ;
    end

    
    incli(1,i) = m(5,i) ;%+ deg2rad(54);
    xx(1,i) = r(1,i)*( cos(omega(1,i))*cos(phi(1,i)) - sin(omega(1,i))*cos(incli(1,i))*sin(phi(1,i)) );
    yy(1,i) = r(1,i)*( sin(omega(1,i))*cos(phi(1,i)) + cos(omega(1,i))*cos(incli(1,i))*sin(phi(1,i)) );
    zz(1,i) = r(1,i)*( sin(incli(1,i))*sin(phi(1,i)) );

end

s = [m(1,:)' xx' yy' zz']


end






