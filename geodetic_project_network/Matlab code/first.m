clear all;clc;
format short;
k=11
     
fi=(0:k)/(k+1)*2*pi;
xC=cos(fi)*200+200;
yC=sin(fi)*200+135;
xC=[xC 200];
yC=[yC 135];

% f = 1+ceil(100.*rand(2*(k+1),1));
% temp=1;
% for i=1:k+1
%     xC(i)=xC(i)+f(temp);
%     yC(i)=yC(i)+f(temp+1);
%     temp=temp+2;
% end


n=k+2;
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
for i=1:n
    D(1,2*i-1)=1;
    D(1,2*i)=0;
    D(2,2*i-1)=0;
    D(2,2*i)=1;
    D(3,2*i-1)=yC(i);
    D(3,2*i)=-xC(i);
end
%     D(3,1:2*n)=[0];
%     D(1,1)=1;
%     D(2,2)=1;
%     D(3,23)=-(yC(13)-yC(12))/l(temp1-1)^2;
%     D(3,24)=(xC(13)-xC(12))/l(temp1-1)^2;
%     D(3,25)=(yC(13)-yC(12))/l(temp1-1)^2;
%     D(3,26)=-(xC(13)-xC(12))/l(temp1-1)^2;

N=inv(A'*A+D'*D)-D'*inv(D*D'*D*D')*D;
%n is teh number of point in Network
R=eye(n*(n-1)/2,n*(n-1)/2)-(A*inv(A'*A+D'*D)*A');
trace(R);
mean(diag(R));
var(diag(R));
(n*(n-1))/2-2*n+3;
relate=[l' diag(R)];
for i=1:(n*(n-1)/2)
    delta(i)=3+(l(i)*2/1000);
    nabla(i)=delta(i)*2.8/sqrt(R(i,i));
end
for i=1:(n*(n-1)/2)
   lambda(i)=2.8^2/((1/R(i,i))-1);
end

temp=1;
for i=1:n
     for j=i+1:n
         if(R(temp,temp)>0.8)
            line([xC(i) xC(j)],[yC(i) yC(j)],'Marker','.','LineStyle','-','Color',[0.5,0,0.5],'LineWidth',1.5);
            grid on;
         end
         if(R(temp,temp)<=0.8&&R(temp,temp)>0.7)
            line([xC(i) xC(j)],[yC(i) yC(j)],'Marker','.','LineStyle','-','Color','g','LineWidth',1.5);
            grid on;
         end
         if(R(temp,temp)<=0.7&&R(temp,temp)>0.6)
            line([xC(i) xC(j)],[yC(i) yC(j)],'Marker','.','LineStyle','-','Color','b','LineWidth',1.5);
            grid on;
         end
         if(R(temp,temp)<=0.6&&R(temp,temp)>0.4)
            line([xC(i) xC(j)],[yC(i) yC(j)],'Marker','.','LineStyle','-','Color','y','LineWidth',1.5);
            grid on;
         end
         if(R(temp,temp)<=0.4)
            line([xC(i) xC(j)],[yC(i) yC(j)],'Marker','.','LineStyle','-','Color','r','LineWidth',1.5);
            grid on;
         end
            temp=temp+1;  
     end

end
xlabel('X ')
ylabel('Y ')
title('purple: ri>0.8 , Green: 0.7<ri<0.8, Blue: 0.6<ri<0.7, Yellow: 0.4<ri<0.6, Red: ri<0.4')
for i=1:n
    text(xC(i),yC(i),num2str(i),'BackgroundColor',[.7 .9 .7]);
    end
    axis equal