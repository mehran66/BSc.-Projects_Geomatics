function y = read_YUMA(x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%        This function read almanac file of GPS satelite in YUMA form 
%
%     PURPOSE:
%                CONVERT ALMANAC FILE TO MATRICE  
%       INPUT:
%                ALMANAC FILE 
%      OUTPUT:
%                MATRICE THAT INCLUDE ALMANAC DATA      
%
%
% ----------------                  HINT                   ----------------
%
% Input x must be in such form ( x = '*.txt')  --->  y=read_YUMA('*.txt')
%
% Output matrix raw is 
%                           1      ID
%                           2      Health
%                           3      Eccentricity
%                           4      Time of Applicability ( s )
%                           5      Orbital Inclination ( rad )
%                           6      Rate of Right Ascen ( r/s )
%                           7      SQRT(A)  ( m^1/2 )
%                           8      Right Ascen at Week ( rad )
%                           9      Argument of Perigee ( rad )
%                          10      Mean Anom ( rad )
%                          11      Af0 ( s )
%                          12      Af1 ( s/s )
%                          13      week 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen(x);
i=0;
x = fscanf(fid,'%c',50);
while x~'';

i=i+1;
x = fscanf(fid,'%s',1);
a(1,i)=str2num(x);%---------------- PRN number
x = fscanf(fid,'%c',9);
x = fscanf(fid,'%s',1);
a(2,i)=str2num(x);%---------------- Health
x = fscanf(fid,'%c',15);
x = fscanf(fid,'%s',1);
a(3,i)=str2num(x);%---------------- Eccentricity
x = fscanf(fid,'%c',27);
x = fscanf(fid,'%s',1);
a(4,i)=str2num(x);%---------------- Time of Applicability ( s )
x = fscanf(fid,'%c',27);
x = fscanf(fid,'%s',1);
a(5,i)=str2num(x);%---------------- Orbital Inclination ( rad )
x = fscanf(fid,'%c',27);
x = fscanf(fid,'%s',1);
a(6,i)=str2num(x);%---------------- Rate of Right Ascen ( r/s )
x = fscanf(fid,'%c',19);
x = fscanf(fid,'%s',1);
a(7,i)=str2num(x);%---------------- SQRT(A)  ( m^1/2 )
x = fscanf(fid,'%c',27);
x = fscanf(fid,'%s',1);
a(8,i)=str2num(x);%---------------- Right Ascen at Week ( rad )
x = fscanf(fid,'%c',27);
x = fscanf(fid,'%s',1);
a(9,i)=str2num(x);%---------------- Argument of Perigee(rad)
x = fscanf(fid,'%c',17);
x = fscanf(fid,'%s',1);
a(10,i)=str2num(x);%--------------- Mean Anom ( rad )

if a(10,i)<0
    a(10,i) = a(10,i) + 2*pi ;
end

x = fscanf(fid,'%c',9);
x = fscanf(fid,'%s',1);
a(11,i)=str2num(x);%--------------- Af0 ( s )
x = fscanf(fid,'%c',11);
x = fscanf(fid,'%s',1);
a(12,i)=str2num(x);%--------------- Af1 ( s/s )
x = fscanf(fid,'%c',7);
x = fscanf(fid,'%s %c',1);
a(13,i)=str2num(x);%--------------- Week
x = fscanf(fid,'%c',50);

end

fclose(fid);
y=a;

end
