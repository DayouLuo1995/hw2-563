function outm = TDMD_prep(x, n)
%X is the origenal data
%n is the amount of replication
%the output is the timedelayed matrix

l = size(x,2);%the amount of column in the matrix x
f = @(n, l)@(y) x(:, y:(l-n+y));
out = arrayfun(f(n,l), 1:n, 'UniformOutput', false);
outm = cell2mat(out');
end