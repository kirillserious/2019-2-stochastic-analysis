function [xs, times] = weiner(t0, t1, x0, x1, alpha, eps)
% Винеровский процесс
%   
    if t1 - t0 < eps
        % Достигли предела точности
        times = [t0, t1];
        xs    = [x0, x1];
    else
        % Не достигли предела точности
        t = (1 - alpha)*t0 + alpha*t1;
        x = randn(1) * sqrt(alpha * (1 - alpha) * (t1 - t0)) + ...
             (1 - alpha) * x0 + alpha * x1;
        
        [xs_left,  times_left]  = weiner(t0, t, x0, x, alpha, eps);
        [xs_right, times_right] = weiner(t, t1, x, x1, alpha, eps);
        
        xs    = [xs_left,    x, xs_right];
        times = [times_left, t, times_right];
end

