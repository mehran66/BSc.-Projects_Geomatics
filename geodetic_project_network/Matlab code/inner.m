clear all;clc;
format short;
xC=[200 250 150 150 150 300 300 300];
yC=[200 200 150 200 250 150 200 250];
% k=10;
% fi=(0:k)/(k+1)*2*pi;
% xC=cos(fi)*200+200;
% yC=sin(fi)*200+135;
% xC=[xC 200];
% yC=[yC 135];
% f = 1+ceil(400.*rand(2*(k+1),1));
% temp=1;
% for i=1:k+1
%     xC(i)=xC(i)+f(temp);
%     yC(i)=yC(i)+f(temp+1);
%     temp=temp+2;
% end
j=1;
for i=1:length(xC)
    x(j)=xC(i);
    x(j+1)=yC(i);
    j=j+2;
end
n=8;
A(1:(n*(n-1)/2),1:2*n)=[0];
temp1=1;
for i=1:n
     for j=i+1:n
        l(temp1)=sqrt((xC(j)-xC(i))^2+(yC(j)-yC(i))^2);
        A(temp1,2*i-1)=-(xC(j)-xC(i))/l(temp1);
        A(temp1,2*i)=-(yC(j)-yC(i))/l(temp1);
        A(temp1,2*j-1)=(xC(j)-xC(i))/l(temp1);
        A(temp1,2*j)=(yC(j)-yC(i))/l(temp1);
        temp1=temp1+1;
    end
end
x_mean=mean(xC);y_mean=mean(yC);
x_std=std(xC);y_std=std(yC);
for i=1:n
    D(1,2*i-1)=1;
    D(1,2*i)=0;
    D(2,2*i-1)=0;
    D(2,2*i)=1;
    D(3,2*i-1)=(yC(i)-y_mean)/y_std;
    D(3,2*i)=-(xC(i)-x_mean)/x_std;
end

    N=inv(A'*A+D'*D)-D'*inv(D*D'*D*D')*D;
    w=randn(n*(n-1)/2,1);
    L=w+l'
    u=A'*w;
    deltax_hat=N*u
    x_hat=x'+deltax_hat
%     ----------------------------------------------------------------------
  
    for i=1:2:(n)*2-1
        Absulot_Ellipsoid = @(x,y) (N(i+1,i+1)*(x-x_hat(i)).^2 -2*N(i,i+1)*(x-x_hat(i))*(y-x_hat(i+1))+ N(i,i)*(y-x_hat(i+1)).^2 - 2.45^2*2000*(N(i,i)*N(i+1,i+1)-N(i,i+1)^2));
        h=ezplot(Absulot_Ellipsoid,[-100,500,-150,450],5)
                set(h,'Color','m','LineWidth',2)
        hold on;
    end

   
for i=1:2:(n)*2-1
     for j=i+2:2:(n)*2-1
        
     line([x_hat(i) x_hat(j)],[x_hat(i+1) x_hat(j+1)],'Marker','.','LineStyle','-','Color','g','LineWidth',.1);
     end
end

for i=1:n
    text(xC(i),yC(i),num2str(i),'BackgroundColor',[.7 .9 .7]);
end

% ----------------------------------------------------------------------
for i=1:2:(n)*2-1
     for j=i+2:2:(n)*2-1
         s1=N(i,i)+N(j,j)-2*N(i,j);
         s2=N(i+1,i+1)+N(j+1,j+1)-2* N(i+1,j+1);
         s3=N(i,i+1)+N(j,j+1)-N(i,j+1)-N(i+1,j);
         x0=(x_hat(i)+x_hat(j))/2;
         y0=(x_hat(i+1)+x_hat(j+1))/2;
         Relative_Ellipsoid = @(x,y) (s2*(x-x0).^2 -2*s3*(x-x0)*(y-y0)+ s1*(y-y0).^2 - 2.45^2*100*s1*s2-s3^2);
        ezplot(Relative_Ellipsoid,[-100,500,-150,450],5)
        hold on;
     end
end
   
axis equal
% ----------------------------------------------------------------------

%         
% j=1
% for i=0:.1:360
% sx(j)=(N(11,11)*(sin(i*pi/180))^2+N(12,12)*(cos(i*pi/180))^2-2*N(11,12)*sin(i*pi/180)*cos(i*pi/180));
% [x1(j),y1(j)]=pol2cart(i*pi/180,sqrt(sx(j)));
% x2(j)=x1(j);
% y2(j)=y1(j);
% j=j+1;
% end
% plot(x2,y2,'r')

         