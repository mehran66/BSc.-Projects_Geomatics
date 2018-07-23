function set=cofficient(str,Fi1,Lambda1,Fi2,Lambda2)
a = 6378137.000000;e=0.081819191;
N1=a/(1-(e^2)*(sin(Fi1)^2))^.5;
N2=a/(1-(e^2)*(sin(Fi2)^2))^.5;
M1=a*(1-e^2)/(1-(e^2)*(sin(Fi1)^2))^(3/2);
M2=a*(1-e^2)/(1-(e^2)*(sin(Fi2)^2))^(3/2);
[alfa21,s12]=Robbins(Fi2,Lambda2,Fi1,Lambda1);
[alfa12,s12]=Robbins(Fi1,Lambda1,Fi2,Lambda2);
if str=='a'
    set=-M1*cos(alfa12);%/206265
end
if str=='b'
    set=N2*sin(alfa21)*cos(Fi2);
end
if str=='c'
    set=-M2*cos(alfa21);
end
if str=='d'
    set=-N2*sin(alfa21)*cos(Fi2);
end
if str=='e'
    set=M1*sin(alfa12)/s12;
end
if str=='f'
    set=N2*cos(alfa21)*cos(Fi2)/s12;
end
if str=='g'
    set=M2*sin(alfa21)/s12;
end
