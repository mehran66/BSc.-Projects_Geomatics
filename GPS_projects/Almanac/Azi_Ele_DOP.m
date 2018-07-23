clc
clear all
close all

x = 'almanac.txt';

ss = [2009 12 20 0 0 0];%--------------------- Start time
ee = [2009 12 20 24 0 0];%-------------------- End time
start = juliandate(ss);
finish = juliandate(ee);
Mask = 10;% ---------------------------------- Mask Angle

%0.166666666511446=4saat
%Step for time is 15 min = (0.0104166665114462)jd;

count = 1;
A = [];
sat_azimuth = [];
sat_zenith = [];
SV = [];

for j = start:0.0104166665114462:finish

    date = jd2gregorian(j);
    time = date(1,4)+date(1,5)/60+date(1,6)/3600;
    phi = [36 40 30];% ------------------------------ Phi 
    phi = dms2deg(phi);
    lambda = [48 29 04];% --------------------------- lambda 
    lambda = dms2deg(lambda);
    h = 1650;% -------------------------------------- Height 
    station = [phi lambda h];

    %----------------------------------------------------------------------

    y = ell2cart(station);
    ss = alm2cart(x,date);
    s = [ss(:,2) ss(:,3) ss(:,4)];

    % -------- Compute Elevation ,Azimuth and Zenith of satellites --------

    k = 1;
    sat_azi = [];
    sat_zen = [];
    satvis = zeros(length(s),1);
    
    for i = 1:size(s)

        z(i,:)=ECEF2local(y,s(i,:));
        
        elevation(i) = sqrt(z(i,1)^2+z(i,2)^2+z(i,3)^2);
        zenith (i) = asind(z(i,3)/elevation(i));
        azimuth(i) = atand (z(i,2)/z(i,1));

        if z(i,1)>=0 & z(i,2)>0
            azimuth(i) = azimuth(i);
        elseif z(i,1)<=0 & z(i,2)>0
            azimuth(i) = azimuth(i)+180;
        elseif z(i,1)<=0 & z(i,2)<0
            azimuth(i) = azimuth(i)+180;
        elseif z(i,1)>=0 & z(i,2)<0
            azimuth(i) = azimuth(i)+360;
        elseif z(i,1)>0 & z(i,2)==0
            azimuth(i) = 0;
        elseif z(i,1)<0 & z(i,2)==0
            azimuth(i) = 180;
        end
        
        % ---------------------------- Mask Angle -------------------------
        
        if zenith(i)>Mask

            zenith(i) = zenith(i);
            satvis(i,1) = ss(i,1);

        else

            azimuth(i) = NaN;
            elevation (i) = NaN;
            zenith(i) = NaN;
            satvis(i,1) = NaN;

        end

        sat_azi =  [sat_azi ;azimuth(i)];
        sat_zen = [sat_zen ; zenith(i)];

    end

    SV = [SV ,satvis];
    sat_azimuth = [sat_azimuth ,sat_azi];
    sat_zenith = [sat_zenith ,sat_zen];
    
    % ---------------------------------------------------------------------
    
    % --------------------------- Compute DOP -----------------------------

    d = 1;
    for i = 1:size(s)

        if zenith(i)>Mask

            dist = sqrt( (s(i,1) - y(1,1))^2 + (s(i,2) - y(1,2))^2 + (s(i,3) - y(1,3))^2 );
            A(d,1) = -( s(i,1) - y(1,1) )/dist;
            A(d,2) = -( s(i,2) - y(1,2) )/dist;
            A(d,3) = -( s(i,3) - y(1,3) )/dist;
            A(d,4) = 3*10^8;
            d = d+1;

        end

    end

    Visible(count,1) = d ; % --------------- Number of visible satellite
    Q = inv(A'*A);
    GDOP(count,1) = sqrt(Q(1,1)+Q(2,2)+Q(3,3)+Q(4,4));
    PDOP(count,1) = sqrt(Q(1,1)+Q(2,2)+Q(3,3));
    HDOP(count,1) = sqrt(Q(1,1)+Q(2,2));
    VDOP(count,1) = sqrt(Q(3,3));
    Time(count,1) = time;
    count = count+1;

    % ---------------------------------------------------------------------

end

% ---------------------------------- Sky Plot -----------------------------

scrsz = get(0,'ScreenSize');
figure('Position',scrsz);
skyPlot(sat_azimuth,sat_zenith,ss(:,1));

% ---------------------- Plot visible GPS Satellites ----------------------

scrsz = get(0,'ScreenSize');
figure('Position',scrsz);

for i = 1:size(s)

    plot(Time,SV(i,:),'k','LineWidth',10)
    title(' Visiblity of GPS Satellites ')
    axis([Time(1,1)-.1 Time(length(Time),1)+.1 min(min(SV))-1 max(max(SV))+1])
    hold on
    
end

% ------------------- Plot number of visible satellites -------------------

scrsz = get(0,'ScreenSize');
figure('Position',scrsz)
subplot(2,1,1)
stairs(Time,Visible)
title(' Number of visible satellites ')
axis([Time(1,1)-.1 Time(length(Time),1)+.1 min(Visible)-1 max(Visible)+1])

% ----------------------------- Plot DOPs ---------------------------------

subplot(2,1,2)
plot(Time,PDOP,'-rs','LineWidth',1,...
    'MarkerEdgeColor','k',...
    'MarkerSize',2)
hold on
plot(Time,HDOP,'-ks','LineWidth',1,...
    'MarkerEdgeColor','k',...
    'MarkerSize',2)
hold on
plot(Time,VDOP,'-bs','LineWidth',1,...
    'MarkerEdgeColor','k',...
    'MarkerSize',2)
title(' Dilution of precision ')
legend(' PDOP ',' HDOP ',' VDOP ',1)
xlabel(' Time [ hours ] ')
grid on

% -------------------------------------------------------------------------
