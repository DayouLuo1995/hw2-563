function [X_out, S, V_t] = DMD(X, R, dt, tf)
%X is the data, with the colums equals to the amount of time spot
% R is the ratio used to pick the amount of vectors used for the approximation.
%dt is the time difference,which is used to give tf unit. it is the time
%difference for each column of X.
%tf is the point that we want to estimate
%The output X_out has the same rows as X and the amount of columns as tf
L = size(X,2);
X1 = X(:, 1:(L-1));
X2 = X(:, 2:L);

[U,S,V] = svd(X1, 'econ');
N = sum(diag(S));
temp =0;
for ii = 1: (L-1)
    temp = temp + S(ii,ii);
    if temp/N >= R
        disp([num2str(ii), "number of vectors are choosen for the apporximation"]);
        break;
    end
end
n = ii;%the amount of vectors choosen for the approximation.
U_t = U(:, 1:n);
V_t = V(:,1:n);
S_t = S(1:n, 1:n);%update the matrx

A_t = U_t' * X2 *V_t/S_t;
[W,D] = eig(A_t);
phi = X2*V_t/S_t * W;

mu = diag(D);
omega = log(mu)/dt;

y0 = phi\X(:,1);%so that t=1 the estimation is not far from X(t =1)

u_modes = zeros(n, length(tf));
for ii = 1:length(tf)
    u_modes(:, ii) = y0.* exp(omega*(tf(ii)));
end
X_out = phi*u_modes;
end
    


