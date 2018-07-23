function B=ReadFile(fid)
%This function read a raw file
%Data description in raw files :
%--------------------------------------------------------------------------
% Data description                                                   Format
%--------------------------------------------------------------------------
% Number M of pings in file                                          int16
% Number N of samples per ping                                       int16
% Repeat cicle - M entries of
%       Year                                                         int64
%       Day of year                                                  int64
%       Time of day since midnight in millisecond                    int64
%       Latitude in decimal degrees * 50,000,000                     int64
%       Longitude in decimal degrees * 50,000,000                    int64
%       Sampling interval in seconds * 1,000,000                     int64
%       Transmit power                                               int64
%       Sound velocity                                               int64
%       Pulse length in seconds * 1,000,000                          int64
%       Gain                                                         int64
%       Absorption coefficient * 1,000,000                           int64
%       Beam width * 10                                              int64
%       Equivalent beamwidth                                         int64
%       Frequency in KHz                                             int64
%       Repeat cicle - N entries of
%               Power in dB * 100                                    int16
%       End of repeat cycle N
% End of repeat cycle M
%-------------------------------------------------------------------------
%Read file
M= fread(fid,1,'int16');
N= fread(fid,1,'int16');
for i=1:M
    for j=1:14
       A(i,j)= fread(fid,1,'int64') ;
    end
    for k=1:N
       A(i,k+14)= fread(fid,1,'int16'); 
    end
end

t=linspace(0,6*10^-6*N,N);
plot(t,A(7,15:end)./100);
[m,n]=size(A);
A(:,15:end)=A(:,15:end)/100;
for i=1:m
ping=A(i,:);
[B(i,1),B(i,2),B(i,3),B(i,4),B(i,5),B(i,6),B(i,7)]=signal_features(ping);
end
%B(i,1)------>Total energy
%B(i,2)------>Timespread   
%B(i,3)------>Skewness
%B(i,4)------>flatness
%B(i,5)------>Latitude
%B(i,6)------>Longitude
%B(i,7)------>Depth

