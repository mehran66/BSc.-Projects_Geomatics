function R=rot(x,axes_x)
if axes_x==1 
R=[1 0 0; 0 cosd(x) sind(x); 0 -sind(x) cosd(x)];    
end
if axes_x==2
R = [cosd(x) 0 -sind(x); 0 1 0;sind(x) 0 cosd(x)];
end
if axes_x==3 
R = [cosd(x) sind(x) 0; -sind(x) cosd(x) 0; 0 0 1];
end