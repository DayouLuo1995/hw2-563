function R = KLdistance(Y, estY)
%Y is the true data
% estY is the estimated data

[f1,x1] = ksdensity(Y);
[f2,x2] =ksdensity(estY);
x = union(x1, x2);
f1 = interp1(x1,f1, x);
f2 = interp1(x2,f2,x);
f1(f1<0.001) = 0.001;
f2(f2<0.001) = 0.001;%avoid large log
f1(isnan(f1)) = 0.001;
f2(isnan(f2)) = 0.001;
integrand = f1.*log(f1./f2);
R = trapz(x, integrand);
end