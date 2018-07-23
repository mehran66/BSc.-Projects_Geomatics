function x = newton(m,e)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This function found eccentric anomaly through newton iteration method
%
%     PURPOSE:
%                CALCULATE ECCENTRIC ANOMOLY (E)
%       INPUT:
%                MEAN ANOMALY (M) AND ECCENTRICITY (e)
%      OUTPUT:
%                ECCENTRIC ANOMOLY (E)
%
%
% ----------------                  HINT                   ----------------
%
% Input mean anomaly must be in radian unit.
%
% Output eccentric anomaly is in radian unit.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

E0 = m;
r = 1;

while abs(r)>10e-5

    w = ( E0 - e*sin(E0) - m );
    v = ( 1 - e*cos(E0) );

    if v==0
        E0 = E0 + 1;
    elseif w==0
        r = 1e-6;
    else
        E = E0 - w/v;
        r = E - E0;
        E0 = E;
    end

end

x = E0;

end