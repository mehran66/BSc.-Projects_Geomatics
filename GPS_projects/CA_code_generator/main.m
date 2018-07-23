clc;clear all;
disp('--------------------------------------------------------------------')
disp('        |                                       |                   ')
disp('        |project by :      mehran ghandehary    |                   ')
disp('        |no : 851921326                         |                   ')
disp('        |********Surveying Engineering**********|                  ')
disp('        |********Isfahan University*************|                   ')
%Homework problem
%***************************2-1***********************************************
%------------->(a)
%  PRN19=CA_prn_genrator(G1(), 19, 0,1);
%  subplot(4,1,1)
%  stairs(PRN19, '-r');xlim([0 1023]);ylim([-2 2])
%  title('Plot all chip (1-1023)','FontSize',12)
%  subplot(4,1,2)
%  stairs(PRN19(1:16), '-r');xlim([0 20]);ylim([-2 2])
%  title('Plot the first 16 chip','FontSize',12)
%  subplot(4,1,3)
%  stairs(PRN19(length(PRN19)-16:end), '-r');xlim([0 20]);ylim([-2 2])
%  title('Plot the last 16 chip','FontSize',12)
%------------->(b)
%  PRN19=CA_prn_genrator(G1(), 19, 0,2);
%  subplot(4,1,4)
%  stairs(PRN19(1024:1039), '-r');xlim([0 20]);ylim([-2 2])
%  title('Plot the first 16 chip (1024-2046)','FontSize',12)
%------------->(c)
%  PRN25=CA_prn_genrator(G1(), 25, 0,1);
%  subplot(3,1,1)
%  stairs(PRN25, '-r');xlim([0 1023]);ylim([-2 2])
%  title('Plot all chip (1-1023) of PRN25','FontSize',12)
%  subplot(3,1,2)
%  stairs(PRN25(1:16), '-r');xlim([0 20]);ylim([-2 2])
%  title('Plot the first 16 chip','FontSize',12)
%  subplot(3,1,3)
%  stairs(PRN25(length(PRN25)-16:end), '-r');xlim([0 20]);ylim([-2 2])
%  title('Plot the last 16 chip','FontSize',12)
%------------->(d)
%  PRN5=CA_prn_genrator(G1(), 5, 0,1);
%  subplot(3,1,1)
%  stairs(PRN5, '-r');xlim([0 1023]);ylim([-2 2])
%  title('Plot all chip (1-1023) of PRN5','FontSize',12)
%  subplot(3,1,2)
%  stairs(PRN5(1:16), '-r');xlim([0 20]);ylim([-2 2])
%  title('Plot the first 16 chip','FontSize',12)
%  subplot(3,1,3)
%  stairs(PRN5(length(PRN5)-16:end), '-r');xlim([0 20]);ylim([-2 2])
%  title('Plot the last 16 chip','FontSize',12)
%***************************2-2********************************************
%------------->(a)
%  [shift R]=Correlation(19,19)
%  stem(shift,R)
%------------->(b)
% PRN1=CA_prn_genrator(G1(), 19, 0,1);
% PRN2=CA_prn_genrator(G1(), 19,-200,1);
% [shift R]=Correlation2(PRN1,PRN2)
% stem(shift,R)
%------------->(c)
%  [shift R]=Correlation(19,25)
%  stem(shift,R)
%------------->(d)
% PRN1=CA_prn_genrator(G1(), 19, 0,1);
% PRN2=CA_prn_genrator(G1(), 5,0,1);
% [shift R]=Correlation2(PRN1,PRN2)
% stem(shift,R)
%------------->(e)
% PRN1=CA_prn_genrator(G1(), 19, 350,1);
% PRN2=CA_prn_genrator(G1(), 25, 905,1);
% PRN3=CA_prn_genrator(G1(), 5, 75,1);
% PRN11=PRN1+PRN2+PRN3;
% PRN22=CA_prn_genrator(G1(), 19, 0,1);
% [shift R]=Correlation2(PRN11,PRN22);
% stem(shift,R)
%------------->(f)
% PRN1=CA_prn_genrator(G1(), 19, 350,1);
% PRN2=CA_prn_genrator(G1(), 25, 905,1);
% PRN3=CA_prn_genrator(G1(), 5, 75,1);
% PRN4=4*randn(1,1023); 
%  subplot(4,1,1)
%  stairs(PRN1, '-r');ylim([-2 2])
%  title('Plot PRN19 delay by 350 chip ','FontSize',12)
%  subplot(4,1,2)
%  stairs(PRN2, '-r');;ylim([-2 2])
%  title('Plot PRN25 delay by 905 chip','FontSize',12)
%  subplot(4,1,3)
%  stairs(PRN3, '-r');ylim([-2 2])
%  title('Plot PRN5 delay by 75 chip','FontSize',12)
%  subplot(4,1,4)
%  stairs(PRN4, '-r');ylim([-6 6])
%  title('NOISE','FontSize',12)
%------------->(g)
PRN1=CA_prn_genrator(G1(), 19, 350,1);
PRN2=CA_prn_genrator(G1(), 25, 905,1);
PRN3=CA_prn_genrator(G1(), 5, 75,1);
PRN4=4*randn(1,1023)';
PRN5=CA_prn_genrator(G1(), 19, 0,1);
PRN6=PRN1+PRN2+PRN3+PRN4;
[shift R]=Correlation2(PRN5,PRN6);
stem(shift,R)


