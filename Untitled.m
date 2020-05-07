clear; clc; close;
load('population.mat')
X = [hare'; lynx'];
t = 1:30; 
timp = linspace(min(t), max(t),1000);
Xhare = interp1(t, hare', timp);
Xlynx = interp1(t, lynx', timp);
t = timp;
X= [Xhare; Xlynx];
%%
%%DMD
R = 0.95;
[Xdmdm1, Sdmd1, V]= DMD(X, R, t(2)-t(1), t);

figure(1);
tnew = year;
tnew = linspace(min(tnew), max(tnew),1000);

plot(tnew, real(Xdmdm1(1,:)));
hold on;
plot(tnew,Xhare);
legend('Prediction', 'Hare');
title('DMD for Hare');
figure(2);

plot(tnew, real(Xdmdm1(2,:)));
hold on;
plot(tnew,Xlynx);
legend('Prediction', 'Lynx');
title('DMD for Lynx');
%%
%%Time delayed DMD
X = [hare'; lynx'];
t = 1:30; 
X_delayed = TDMD_prep(X, 10);

[Xtdmd, Stdmd, Vtdmd] = DMD(X_delayed, 0.95, t(2)-t(1), t);%14eignevalues


figure(3)

f1 = axes;
plot(year, hare, '--');
hold on;
plot(f1, year,real(Xtdmd(1,:)));
%plot(t,X(1,:));
figure(4)
f2 = axes;
hold on;
plot(year, lynx, '--');
plot(f2,year,real(Xtdmd(2,:)));
%plot(t,lynx);

[Xtdmd, Stdmd, Vtdmd] = DMD(X_delayed, 0.8, t(2)-t(1), t);%

plot(f1, year,real(Xtdmd(1,:)));

plot(f2,year,real(Xtdmd(2,:)));

[Xtdmd, Stdmd, Vtdmd] = DMD(X_delayed, 0.5, t(2)-t(1), t);%
plot(f1, year,real(Xtdmd(1,:)));
plot(f2,year,real(Xtdmd(2,:)));

[Xtdmd, Stdmd, Vtdmd] = DMD(X_delayed, 0.3, t(2)-t(1), t);%
plot(f1, year,real(Xtdmd(1,:)));
plot(f2,year,real(Xtdmd(2,:)));
%%:LVmodel
%%:Nonlinear fit
legend(f1,'Hare','14 modes','8 modes','3 modes', '1 modes')
legend(f2,'Lynx','14 modes','8 modes','3 modes', '1 modes')
title(f1,'Time delayed DMD of Hare');
title(f2,'Time delayed DMD of Lynx');


[Xtdmd1, Stdmd, Vtdmd] = DMD(X_delayed, 0.8, t(2)-t(1), t);
[Xtdmd2, Stdmd, Vtdmd] = DMD(X_delayed, 0.95, t(2)-t(1), t);
%%
%LV
timp = linspace(min(t), max(t),1000);
Xhare = interp1(t, hare', timp);
Xlynx = interp1(t, lynx', timp);
t = timp;
X= [Xhare; Xlynx];
yylv = LVmodel(X,t);

tnew = year;
tnew = linspace(min(tnew), max(tnew),1000);

figure(4);
f4 = axes;
plot(tnew,Xhare);
hold on;
plot(tnew, yy(:,1));
legend('Hare', 'Prediction');
title('Lotka-Volaterra for hare');

figure(5);
f5 = axes;
plot(tnew,Xlynx);
hold on;
plot(tnew, yy(:,2));
legend('Lynx', 'Prediction');
title('Lotka-Volaterra for lynx');



%%

t = 1:30; 
timp = linspace(min(t), max(t),1000);
Xhare = interp1(t, hare', timp);
Xlynx = interp1(t, lynx', timp);
tnew = timp;
X= [Xhare; Xlynx];
yy= fitnonlinear(X, tnew);

figure(6);

f4 = axes;
plot(tnew,Xhare);
hold on;
plot(tnew, yy(:,1));
legend('Hare', 'Prediction');
title('Nonlinear fit for hare');

figure(7);
f5 = axes;
plot(tnew,Xlynx);
hold on;
plot(tnew, yy(:,2));
legend('Lynx', 'Prediction');
title('Nonlinear fit  for lynx');

%%
%%KL distance for hare
%%KL o.8Tdmd
R(1) = KLdistance(real(Xtdmd1(1,:)), Xhare);
R(2) = KLdistance(real(Xtdmd1(2,:)), Xhare);
%%LV
R(3) = KLdistance(yylv(:,1), Xhare);
R(4) = KLdistance(yy(:,1), Xhare);
R(5) = KLdistance(real(Xdmdm1(1,:)), Xhare);

%%AIC & BIC hare
%%TDMD 0.8, LV and Regression.
%% we only test on the original scale
x1 = real(Xtdmd1(1,:));
lx1 = loglikelihood(hare', x1);
k = 10;
Aic(1) = 2*k - lx1;
Bic(1) = log(30)*k - lx1;

x2 = yylv(:,1);
x2 = interp1(t, x2, 1:30);
lx2 = loglikelihood(hare', x2);
k = 4;
Aic(2) = 2*k - lx2;
Bic(2) = log(30)*k - lx2;

x2 = yy(:,1);
x2 = interp1(t, x2, 1:30);
lx2 = loglikelihood(hare', x2);
k = 6;
Aic(3) = 2*k - lx2;
Bic(3) = log(30)*k - lx2;




