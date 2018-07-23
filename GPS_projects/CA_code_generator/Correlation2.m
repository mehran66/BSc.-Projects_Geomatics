function [shift R]=Correlation2(PRN1,PRN2)
% IN THE NAME OF GOD
%Function for normalized Cross-correlation and outo-correlation
%if prn_num1 = prn_num2 ---->outo-correlation function
%if prn_num1 != prn_num2 ---->cross-correlation function
% inputs
%     PRN1 and PRN2
% output
%	shift 0,1,-1,2,-2,....
%   R=(outo or cross)correlation function

shift(1,:)=0;
temp1=1;
for i=2:2:1000
shift(i,:)=temp1;
shift(i+1,:)=-temp1;
temp1=temp1+1;
end
R(1)=dot(PRN1,PRN2)/1023;
temp2=PRN2;
for i=2:length(shift)
   PRN=temp2; 
   if shift(i) < 0
   shift1 = -shift(i);
   PRNtemp = PRN((shift1+1):end);
   PRNtemp = [PRNtemp; PRN(1:shift1)];
   PRN = PRNtemp;
elseif shift(i) > 0
   shift1 = length(shift) - shift(i);
   PRNtemp = PRN((shift1+1):end);
   PRNtemp = [PRNtemp; PRN(1:shift1)];
   PRN = PRNtemp;
end
PRN2=PRN;
R(i)=dot(PRN1,PRN2)/1023;
end


 





