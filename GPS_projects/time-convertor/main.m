
clc;clear all;format long g;
disp('--------------------------------------------------------------------')
disp('        |                                       |                   ')
disp('        |project by :      mehran ghandehary    |                   ')
disp('        |no : 851921326                         |                   ')
disp('        |********Surveying Engineering**********|                  ')
disp('        |********Isfahan University*************|                   ')
disp('        |********time convertor*****************|                   ')
disp('--------------------------------------------------------------------')
disp('What do you want to do :')
disp('1-convert Civil date to julian date :')
disp('2-convert Civil date to gps time:')
disp('3-convert julian date to civil date:')
choice=input('Input your choice :');
if choice==1
    y=input('Input year:');
    m=input('Input mounth :');
    d=input('Input day :');
    time=input('time[hour minute second] :');
    h=time(1)+time(2)/60+time(3)/3600;
    jd = julday(y,m,d,h);
end
if choice==2
    y=input('Input year:');
    m=input('Input mounth :');
    d=input('Input day :');
    time=input('time[hour minute second] :');
    h=time(1)+time(2)/60+time(3)/3600;
     jd = julday(y,m,d,h);
    [TOW,DOW,Week] = GPS_T(jd);
end
if choice==3
    x=input('Input julian day number:');
    [Year Month Day Hour Minute Second] = jd2civil(x)
end
