[m,n,k] = size(BZ_tensor);
for j = 1:k
    A = BZ_tensor(:,:,j);
    pcolor(A), shading interp, pause(0.01);
end
% 
% the datasize is too large. We need to cut a small part from it
% We pick the piece of 175:225, 275:325
% for j = 1:600
%     A = BZ_tensor(175:225, 275:325,j);
%     pcolor(A), shading interp, pause(0.01);
% end

%Given the data from 1:400, we want to predict the behaviour of this part
%for t = 500:600
%DMD
BZ_small = BZ_tensor(175:225, 275:325, :);
[m,n,k] = size(BZ_small);
X = zeros(m*n, k);
for ii = (1:n)-1
    for jj = 1:m
        X(ii*m+jj, :) = BZ_small(jj, ii+1,:);
    end
end
%Use DMD
dt = 1;
tf = 500:600;
X_train = X(:,1:400);
R = 0.99;%99 308 90 43
%80 4
[X_out, S, V_t] = DMD(X_train, R, dt, tf);
subplot(2,4,5)
for j = length(tf)
    A = X_out(:,j);
    A = reshape(A, m,n);
    pcolor(real(A)), shading interp, pause(0.01);
end

for j = 600
subplot(2,4,1)
    A = BZ_tensor(175:225, 275:325,j);
    pcolor(A), shading interp, pause(0.01);
end
%%TDMD
delay = 40;
X_tdmd = TDMD_prep(X_train, delay);
R = 0.72;%90 59 99 312 80 6
[X_out, S, V_t] = DMD(X_tdmd, R, dt, tf);
subplot(2,4,6)
for j = 1:length(tf)
    A = X_out(1:m*n,j);
    A = reshape(A, m,n);
    pcolor(real(A)), shading interp, pause(0.1);
end

%%%How about we do a larger scale.
BZ_small = BZ_tensor(150:300,150:450, :);
[m,n,k] = size(BZ_small);
X = zeros(m*n, k);
for ii = (1:n)-1
    for jj = 1:m
        X(ii*m+jj, :) = BZ_small(jj, ii+1,:);
    end
end
%Use DMD
dt = 1;
tf = 500:600;
X_train = X(:,1:400);
R = 0.80;%337, 47, 
[X_out, S, V_t] = DMD(X_train, R, dt, tf);
for j = 1:length(tf)
    A = X_out(:,j);
    A = reshape(A, m,n);
    pcolor(real(A)), shading interp, pause(0.01);
end
for j = 500:600
    A = BZ_tensor(150:300,150:450,j);
    pcolor(A), shading interp, pause(0.01);
end
%%TDMD
delay = 40;
X_tdmd = TDMD_prep(X_train, delay);
R = 0.9;
[X_out, S, V_t] = DMD(X_tdmd, R, dt, tf);
for j = 1:length(tf)
    A = X_out(1:m*n,j);
    A = reshape(A, m,n);
    pcolor(real(A)), shading interp, pause(0.01);
end
