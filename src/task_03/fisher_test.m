function [statistic, freedom_degrees, p_value] = fisher_test (xs, ys)
    n = numel(xs);
    x_mean = sum(xs) / n;
    x_var  = sum((xs - x_mean).^2) / (n - 1);
    
    m = numel(ys);
    y_mean = sum(ys) / m;
    y_var  = sum((ys - y_mean).^2) / (m - 1);
    
    statistic = x_var / y_var;
    freedom_degrees = [n- 1, m - 1];
    [~, p_value] = vartest2(xs, ys);
end

