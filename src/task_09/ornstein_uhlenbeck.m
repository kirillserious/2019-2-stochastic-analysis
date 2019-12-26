function [xs, times] = ornstein_uhlenbeck (t0, t1, x0, x1, ... 
                                           squared_sigma, lambda, eps)
%  Процесс Орнштейна-Уленбека
% 
    if t1 - t0 < eps
            xs    = [x0, x1];
            times = [t0, t1];
    else
        t = (t0 + t1) / 2;
        x = randn(1) * sqrt(squared_sigma * (1-exp(-lambda * (t1-t0))) / (1 + exp(-lambda * (t1-t0)))) ...
             + (x0+x1) * exp(-lambda * (t1-t0)/2) / (1 + exp (-lambda * (t1-t0)));
         
        [xs_left,  times_left]  = ornstein_uhlenbeck(t0, t, x0, x, squared_sigma, lambda, eps);
        [xs_right, times_right] = ornstein_uhlenbeck(t, t1, x, x1, squared_sigma, lambda, eps);
        
        xs    = [xs_left,    x, xs_right];
        times = [times_left, t, times_right];
    end
end

