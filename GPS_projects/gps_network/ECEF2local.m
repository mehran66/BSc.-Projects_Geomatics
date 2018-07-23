function [std_U,std_N,std_H] = ECEF2local(point_number,Cx_hat)  
if point_number==309
k=[dms2deg([47 23 42.1315]),dms2deg([9 39 06.7501]),454.6084];
phi=k(1);lambda=k(2);h=k(3);
q=[Cx_hat(1,1),Cx_hat(1,2),Cx_hat(1,3);Cx_hat(2,1),Cx_hat(2,2),Cx_hat(2,3);Cx_hat(3,1),Cx_hat(3,2),Cx_hat(3,3)];
end
if point_number==311
k=[dms2deg([47 23 12.44956]),dms2deg([9 38 14.81397]),454.8585];
phi=k(1);lambda=k(2);h=k(3);
q=[Cx_hat(4,4),Cx_hat(4,5),Cx_hat(4,6);Cx_hat(5,4),Cx_hat(5,5),Cx_hat(5,6);Cx_hat(6,4),Cx_hat(6,5),Cx_hat(6,6)];
end
if point_number==315
k=[dms2deg([47 23 2.52377]),dms2deg([9 38 20.12157]),461.3014];
phi=k(1);lambda=k(2);h=k(3);
q=[Cx_hat(7,7),Cx_hat(7,8),Cx_hat(7,9);Cx_hat(8,7),Cx_hat(8,8),Cx_hat(8,9);Cx_hat(9,7),Cx_hat(9,8),Cx_hat(9,9)];
end
if point_number==401
k=[dms2deg([47 23 33.30053]),dms2deg([9 40 04.10243]),456.5356];
phi=k(1);lambda=k(2);h=k(3);
q=[Cx_hat(10,10),Cx_hat(10,11),Cx_hat(10,12);Cx_hat(11,10),Cx_hat(11,11),Cx_hat(11,12);Cx_hat(12,10),Cx_hat(12,11),Cx_hat(12,12)];
end
R = [ -sin(phi)*cos(lambda) -sin(lambda) cos(phi)*cos(lambda)
    -sin(phi)*sin(lambda)  cos(lambda) cos(phi)*sin(lambda)
    cos(phi)            0           sin(phi)        ];
Q=q*R*q';
std_U=Q(1,1);std_N=Q(2,2);std_H=Q(3,3);