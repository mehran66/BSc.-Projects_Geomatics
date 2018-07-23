function ret=test_sigma02(sig02,s02,df,alpha)
y=df*sig02/s02;
if y<chi2inv(1-alpha,df)
    ret=1;
else
    ret=0;
end


