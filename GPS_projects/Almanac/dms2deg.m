function y = dms2deg(x)

format long g;
y = ( x(1,1) + x(1,2)/60 + x(1,3)/3600 );

end