function y = ell2cart(x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This function convert Ellipsoidal coordinate to Cartesian coordinate
%
%             Ellipsoid parameter used here is WGS84 ellipsoid
%
%     PURPOSE:
%                CONVERT ELLIPSOIDAL COORDINATE TO CARTESIAN COORDINATE
%       INPUT:
%                ELLIPSOIDAL COORDINATE ( PHI LAMBDA H )
%      OUTPUT:
%                CARTESIAN COORDINATE ( X Y Z )
%
%
% ----------------                  HINT                   ----------------
%
% Input x must be in such form ( x = [phi lambda h]). Phi and lambda are
% in radian unit and h in meter unit
%
% Output matrix is in meter unit
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format long g;

% --------------------------- WGS84 Parameter -----------------------------

a = 6378137;
f = 1/298.257223563;
b = a*( 1-f );
e = sqrt( 1 - ( b^2/a^2 ) );

% -------------------------------------------------------------------------

phi = deg2rad( x(1,1) );
lambda = deg2rad( x(1,2) );
h = x(1,3);

N = a/sqrt(1-e^2*sin(phi)^2);

xct = ( N+h )*cos(phi)*cos(lambda);
yct = ( N+h )*cos(phi)*sin(lambda);
zct = ( (1-e^2)*N + h )*sin(phi);

y = [xct yct zct];

end
