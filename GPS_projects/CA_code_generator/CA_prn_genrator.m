 function [PRN] = CA_prn_genrator(G1, prn_num, shift,repeat)
 % IN THE NAME OF GOD
%Algoritem for creating the C/A code
% inputs
%    G1:  1 + x^3 + X^10 (-1,1) as column vector, 
%    prn_num: PRN number, from 1-37
%    shift: number of bits to shift
%    repeat : if one -->(1-1023) or if tow --> (1-1023)+(1024-2046)
% output
%	PRN: C/A sequence (-1,1) as column vector
%



n = 10;	% number of bits in register
switch prn_num
case 1
   PhaseSelection1 = 2; PhaseSelection2 = 6;
case 2
   PhaseSelection1 = 3; PhaseSelection2 = 7;
case 3
   PhaseSelection1 = 4; PhaseSelection2 = 8;
case 4 
   PhaseSelection1 = 5; PhaseSelection2 = 9;
case 5
   PhaseSelection1 = 1; PhaseSelection2 = 9;
case 6
   PhaseSelection1 = 2; PhaseSelection2 = 10;
case 7
   PhaseSelection1 = 1; PhaseSelection2 = 8;
case 8
   PhaseSelection1 = 2; PhaseSelection2 = 9;
case 9
   PhaseSelection1 = 3; PhaseSelection2 = 10;
case 10
   PhaseSelection1 = 2; PhaseSelection2 = 3;
case 11
   PhaseSelection1 = 3; PhaseSelection2 = 4;
case 12
   PhaseSelection1 = 5; PhaseSelection2 = 6;
case 13
   PhaseSelection1 = 6; PhaseSelection2 = 7;
case 14
   PhaseSelection1 = 7; PhaseSelection2 = 8;
case 15
   PhaseSelection1 = 8; PhaseSelection2 = 9;   
case 16
   PhaseSelection1 = 9; PhaseSelection2 = 10;   
case 17
   PhaseSelection1 = 1; PhaseSelection2 = 4;   
case 18
   PhaseSelection1 = 2; PhaseSelection2 = 5;   
case 19
   PhaseSelection1 = 3; PhaseSelection2 = 6;   
case 20
   PhaseSelection1 = 4; PhaseSelection2 = 7;   
case 21
   PhaseSelection1 = 5; PhaseSelection2 = 8;   
case 22
   PhaseSelection1 = 6; PhaseSelection2 = 9;   
case 23
   PhaseSelection1 = 1; PhaseSelection2 = 3;   
case 24
   PhaseSelection1 = 4; PhaseSelection2 = 6;   
case 25
   PhaseSelection1 = 5; PhaseSelection2 = 7;   
case 26
   PhaseSelection1 = 6; PhaseSelection2 = 8;   
case 27
   PhaseSelection1 = 7; PhaseSelection2 = 9; 
case 28
   PhaseSelection1 = 8; PhaseSelection2 = 10;   
case 29
   PhaseSelection1 = 1; PhaseSelection2 = 6;   
case 30
   PhaseSelection1 = 2; PhaseSelection2 = 7;
case 31
   PhaseSelection1 = 3; PhaseSelection2 = 8;   
case 32
   PhaseSelection1 = 4; PhaseSelection2 = 9;   
case 33
   PhaseSelection1 = 5; PhaseSelection2 = 10;   
case 34
   PhaseSelection1 = 4; PhaseSelection2 = 10;   
case 35
   PhaseSelection1 = 1; PhaseSelection2 = 7;   
case 36
   PhaseSelection1 = 2; PhaseSelection2 = 8;   
case 37
   PhaseSelection1 = 4; PhaseSelection2 = 10;   
otherwise
   PRN = 0;
   disp([' Error: not valid PRN number (1 - 10)'])
   return
end

% initilize variables
register2 = ones(1,n);
count = 0;
end_chip=1023*repeat;
if repeat>1
    for i=1:repeat-1
    G1=[G1;G1]
    end
end
for i=1:end_chip
   
   % add counter
   count = count + 1;
   
   % check XOR  on second register
   o2 = xor(register2(2),xor(register2(3),xor(register2(6),xor(register2(8),xor(register2(9),register2(10))))));
  
   % Save final PRN sequence
   if G1(count) == 1
      reg1 = 0;
   else
      reg1 = 1;
   end
   
   PRN(count,:) = xor(reg1, xor(register2(PhaseSelection1), register2(PhaseSelection2)));
      
   % shift values
   for i = (n-1):-1:1
      register2(i+1) = register2(i);
   end
   register2(1) = o2;
end


% check shift range
if shift >= count
   disp([' Error: shift out of range'])
   PRN = 0;
   return
end

% shift PRN sequence
if shift < 0
   shift = -shift;
   PRNtemp = PRN((shift+1):end);
   PRNtemp = [PRNtemp; PRN(1:shift)];
   PRN = PRNtemp;
elseif shift > 0
   shift = count - shift;
   PRNtemp = PRN((shift+1):end);
   PRNtemp = [PRNtemp; PRN(1:shift)];
   PRN = PRNtemp;
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

