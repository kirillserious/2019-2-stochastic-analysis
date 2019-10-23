function [statistic, freedom_degrees, p_value] = student_test (xs, mean)
    n = numel(xs);
    real_mean = sum(xs) / n;
    real_var  = sum((xs - real_mean).^2) / (n - 1);
    
    statistic = (real_mean - mean) / (sqrt(real_var / n));
    freedom_degrees = n - 1;
    
    [~, p_value] = ttest(xs, mean);
end

