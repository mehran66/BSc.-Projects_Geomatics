function g=outliers(v_hat,Cv_hat)
T=2.77;
g=0;
s=1;
for i=1:size(v_hat)
    w(i)=v_hat(i)/sqrt(Cv_hat(i,i));
    if v_hat(i)<T*sqrt(Cv_hat(i,i))&&v_hat(i)>-T*sqrt(Cv_hat(i,i))
        g(s)=i;
        s=s+1;
        w(i)
    end
end



