clc;clear all;format long g;
disp('--------------------------------------------------------------------')
disp('        |                                       |                   ')
disp('        |project by :      Mehran Ghandehary    |                   ')
disp('        |                  Mehdi Latifi         |                   ')
disp('        |                  Hamed Saiedi         |                   ')
disp('        |********Surveying Engineering**********|                  ')
disp('        |********Isfahan University*************|                   ')
disp('        |********Hydrography project************|                   ')
disp('--------------------------------------------------------------------')
B=[];
%Read Files
for i=1:191
g=sprintf('%i.raw',i);
fid = fopen(g,'r','b');
L=ReadFile(fid);
B=[B;L];
fclose('all');
i
end
%B(i,1)------>Total energy
%B(i,2)------>Timespread   
%B(i,3)------>Skewness
%B(i,4)------>flatness
%B(i,5)------>Latitude
%B(i,6)------>Longitude
%B(i,7)------>Depth
[m,n]=size(B);
mean_E=mean(B(:,1));std_E=std(B(:,1));
mean_Ts=mean(B(:,2));std_Ts=std(B(:,2));
mean_S=mean(B(:,3));std_S=std(B(:,3));
mean_F=mean(B(:,4));std_F=std(B(:,4));
%Normalize Total energy,Timespread,Skewness,flatness
for i=1:m
    B(i,1)=(B(i,1)-mean_E)/std_E;
    B(i,2)=(B(i,2)-mean_Ts)/std_Ts;
    B(i,3)=(B(i,3)-mean_S)/std_S;
    B(i,4)=(B(i,4)-mean_F)/std_F;
end
count=1;
%Moving Average
for i=1:10:m-10
    C(count,1)=mean(B(i:i+10,1));
    C(count,2)=mean(B(i:i+10,2));
    C(count,3)=mean(B(i:i+10,3));
    C(count,4)=mean(B(i:i+10,4));
    C(count,5)=mean(B(i:i+10,5));  
    C(count,6)=mean(B(i:i+10,6));
    C(count,7)=mean(B(i:i+10,7));
    count=count+1;
end
[m,n]=size(C);
mean_E=mean(C(:,1));std_E=std(C(:,1));
mean_Ts=mean(C(:,2));std_Ts=std(C(:,2));
mean_S=mean(C(:,3));std_S=std(C(:,3));
mean_F=mean(C(:,4));std_F=std(C(:,4));
%Normalize Total energy,Timespread,Skewness,flatness
for i=1:m
    C(i,1)=(C(i,1)-mean_E)/std_E;
    C(i,2)=(C(i,2)-mean_Ts)/std_Ts;
    C(i,3)=(C(i,3)-mean_S)/std_S;
    C(i,4)=(C(i,4)-mean_F)/std_F;
end 
figure;
Y=C(:,1:4);
sigma=Y'*Y;
%Decomposition
[U,S,V] = svd(sigma);
X=Y*U;
%Clustring
idx=kmeans(X,3);
plot(C(idx==1,6),C(idx==1,5),'r.','MarkerSize',12)
hold on
plot(C(idx==2,6),C(idx==2,5),'b.','MarkerSize',12)
hold on
plot(C(idx==3,6),C(idx==3,5),'y.','MarkerSize',12)
legend('Cluster 1','Cluster 2','Cluster 3',...
       'Location','NW');
figure;
%Plot bathymetric map
scatter3(C(:,6),C(:,5),C(:,7))