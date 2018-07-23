clc;clear all;
for i=1:500
    Fi0(i)=randint(1,1,[-90,90]);
    Lambda0=randint(1,1,[-90,90]);
    h0=randint(1,1,[-1000,10000]);
    [X,Y,Z]= fil2xyz(deg2rad(Fi0(i)),deg2rad(Lambda0),h0)
    %First itterative Function
    [Fi1(i),Lambda1,h1]=xyz2filh1(X,Y,Z);
    %Close form Function  dont have soulotion
    [Fi2(i),Lambda2,h2]=xyz2filh2(X,Y,Z);
    %itterative Bowring Function
    [Fi3(i),Lambda3,h3]=xyz2filhBowring(X,Y,Z);
    e1(i)=Fi1(i)-Fi0(i);
    e2(i)=Fi2(i)-Fi0(i);
    e3(i)=Fi3(i)-Fi0(i);
    

end
    mean1=mean(e1)
    mean2=mean(e2)
    mean3=mean(e3)
    std1=std(e1)
    std2=std(e2)
    std3=std(e3)
    stem(Fi1,e1)
    stem(Fi3,e2)
    stem(Fi3,e3)
    
    

