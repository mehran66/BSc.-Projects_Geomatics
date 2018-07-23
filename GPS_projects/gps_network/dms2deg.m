function y = dms2deg(x)
format long g;
y = ( x(1) + x(2)/60 + x(3)/3600 );
end