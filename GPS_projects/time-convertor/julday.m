function jd = julday(y,m,d,h)
% JULDAY  Conversion of date as given by
%         y ... year (four digits)
%         m ... month
%         d ... day
%         h ... hour and fraction of it

      if m <= 2, y = y-1; m = m+12; end
      jd = floor(365.25*(y+4716))+floor(30.6001*(m+1))+d+h/24-1537.5;


