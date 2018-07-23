function x = gpstime(s)   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%        This function compute Gps time from Gregorian calendar date  
%
%     PURPOSE:
%                COMPUTE GPS TIME ( WEEK & DAY & SECOND )  
%       INPUT:
%                GREGORIAN DATE ( CIVIL DATE )  
%      OUTPUT:
%                GPS TIME       
%
%
% ----------------                  HINT                   ----------------
%
% Input must be in such form ( s = [ YEAR MONTH DAY HOUR MINUTE SECOND] )  
%
% Output  is 
%                           x  =  [ x1 x2 x3 ]
%
%                           x1     Week of GPS
%                           x2     Day of week
%                           x3     Seconds of Week
%           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format long g;
m = juliandate([1980 1 6]);% ------- Epoch of start GPS time in julian day

t = juliandate(s);
n = t-m;

x1 = floor(n/7)-1024;% ------------- Week of GPS
x2 = mod(n,7);% -------------------- Day of week
x3 = x2*86400+15;% ----------------- Seconds of Week
x = [x1 x2 x3];

end