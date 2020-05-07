function yy = LVmodel(X, t)
%X is the dataset, which should be 2rows * N columns
%dt is the time increasement of each columns.
%we will use regression to find out the most proper LV coefficient
%then we use this LV model to predict the amount of
%predator and pray for the same time points as X
%the output is yy, which has the same amount of items as the columns of 
%X
dt = t(2) - t(1);
L = size(X,2);
dx = (X(:, 3:L) - X(:, 1:(L-2)))/(2*dt);
X_ode = X(:, 2:(L-1));
dx_hare = dx(1,:);
dx_lynx = dx(2,:);
X_hare = X_ode(1,:);
X_lynx = X_ode(2,:);
X_harelynx = X_hare.*X_lynx;
%%Make them column vectors;
dx_hare = dx_hare';
dx_lynx = dx_lynx';
X_hare = X_hare';
X_lynx = X_lynx';
X_harelynx = X_harelynx';

%regression for lynx
rd = [X_harelynx, -1*X_lynx]\dx_lynx;
r = rd(1);
d= rd(2);


%regression for hare
bq = [X_hare,  -1*X_harelynx]\dx_hare;
b = bq(1);
q = bq(2);


oderhs = @(t,y) [(b-q*y(2))*y(1); (r*y(1)-d)*y(2)];

[tt, yy] = ode45(oderhs, t, X(:,1));
end









