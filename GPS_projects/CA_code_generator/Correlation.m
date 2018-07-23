function [shift R]=Correlation(prn_num1,prn_num2)
% IN THE NAME OF GOD
%Function for normalized Cross-correlation and outo-correlation
%if prn_num1 = prn_num2 ---->outo-correlation function
%if prn_num1 != prn_num2 ---->cross-correlation function
% inputs
%     prn_num: PRN number, from 1-37
% output
%	shift 0,1,-1,2,-2,....
%   R=(outo or cross)correlation function
PRN1 = CA_prn_genrator(G1(), prn_num1, 0,1);
shift(1,:)=0;
temp=1;
for i=2:2:1000
shift(i,:)=temp;
shift(i+1,:)=-temp;
temp=temp+1;
end
for i=1:length(shift)
PRN2 = CA_prn_genrator(G1(), prn_num2, shift(i),1);   
R(i)=dot(PRN1,PRN2)/1023;
end


 





