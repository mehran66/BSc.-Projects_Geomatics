function z = ECEF2local(x,y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This function referenced satellite position to the user position in
%   east,north,and height
%
%     PURPOSE:
%                CONVERT CARTESIAN COORDINATE TO LOCAL COORDINATE
%       INPUT:
%                CARTESIAN COORDINATE OF STATION AND SATELLITE
%      OUTPUT:
%                EAST,NORTH AND HEIGHT OF SATELLITE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format long g;

% -------------------------------------------------------------------------

%     Performs transformation from cartesian coordinates to ellipsoidal
%                             coordinates on wgs84

xx = cart2ell(x,'wgs84');

% -------------------------------------------------------------------------

lambda = deg2rad( xx(1,1) );
phi = deg2rad( xx(1,2) );

R = [ -sin(phi)*cos(lambda) -sin(lambda) cos(phi)*cos(lambda)
    -sin(phi)*sin(lambda)  cos(lambda) cos(phi)*sin(lambda)
    cos(phi)            0           sin(phi)        ];

dif = y'-x';
z = R'*dif;

end
