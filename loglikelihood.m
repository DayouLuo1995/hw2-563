function lg = loglikelihood(Ty, Ey)
%this function returns the log likelihood for the normal distribution
%we assume TY are independent normal distributions that shares the 
%the variance. lg is the loglikehood, which is the log of product of
%distribution function.

sigma2 = sum((Ty - Ey).^2)/ (length(Ty)-1);%estimate the variance
n = length(Ty);
lg = -n/2 *log(2*pi) - n/2 * log(sigma2) - sum((Ty - Ey).^2)/(2*sigma2);%The last term is a constant
end