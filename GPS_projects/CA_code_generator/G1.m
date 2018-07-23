 function [G1] =G1() 
%Algoritem for creating the G1 code
n=10;% number of bits in register

% initilize variables
register1 = ones(1,n);
count = 0;

for i=1:1023
   
   % add counter
   count = count + 1;
   
   PRN(count,:) = register1(10);
   
   % check XOR on first register
   o1 = xor(register1(3), register1(10));
   
         
   % shift values
   for i = (n-1):-1:1
      register1(i+1) = register1(i);
   end
   register1(1) = o1;
   
end
PRNtemp=[];
% reset high/low values to -1/1
for i = 1:length(PRN)
   if PRN(i) == 1
      PRNtemp(i,:) = -1;
   else
      PRNtemp(i,:) = 1;
   end
end
PRN = PRNtemp;
G1=PRN;
% 



