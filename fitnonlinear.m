function yy = fitnonlinear(X, t)
%input is the data x and the time vector t
%the output is the coeffcient picked for the ode of hare and lynx.
dt = t(2) - t(1);
L = size(X,2);
dx = (X(:, 3:L) - X(:, 1:(L-2)))/(2*dt);
X_ode = X(:, 2:(L-1));
dx_hare = dx(1,:);
dx_lynx = dx(2,:);
X_hare = X_ode(1,:);
X_lynx = X_ode(2,:);
dx_hare = dx_hare';
dx_lynx = dx_lynx';
X_hare = X_hare';
X_lynx = X_lynx';
X_ode = X_ode';%%Prepare all the ingredient


%%%%%
A = [ones(size(X_ode,1), 1), X_ode, X_ode.^2, X_ode.^3,...
    sin(X_ode), cos(X_ode), tan(X_ode)];

[B1, FitInfo] = lasso(A, dx_hare,'CV', 5);
idxLambdaMSE = FitInfo.IndexMinMSE;
% figure(1);
%  lassoPlot(B1,FitInfo,'PlotType','CV');
B1 = B1(:,idxLambdaMSE);

[B2, FitInfo] = lasso(A, dx_lynx, 'CV', 5);
% figure(2);
%  lassoPlot(B2,FitInfo,'PlotType','CV');
idxLambdaMSE = FitInfo.IndexMinMSE;
B2= B2(:,idxLambdaMSE);
%%this is the regression;
    function dy = rhs(t,y)
        dhare = [1, y', y'.^2, y'.^3,sin(y'), cos(y'), tan(y')] * B1;
        dlynx = [1, y', y'.^2, y'.^3, sin(y'), cos(y'), tan(y')] * B2;
        dy = [dhare; dlynx];
    end
[~, yy] = ode45(@rhs, t, X(:,1));
end

