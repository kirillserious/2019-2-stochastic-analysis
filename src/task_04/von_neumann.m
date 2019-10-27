function xs = von_neumann (vecsize)
    xs = zeros(1, vecsize);
    
    rho_cauchy = @(xs, a, b)  b./((xs - a).^2 + b^2)/pi;
    rho_normal = @(xs)        exp(-xs.^2./2)./((2*pi)^(1/2));
    
    a_optimal  = 0;
    b_optimal  = 1;
    k_optimal  = sqrt(2*pi/exp(1));
    
    i = 1;
    while i <= vecsize
        x_cauchy = cauchy_generate(a_optimal, b_optimal);
        frac = rho_normal(x_cauchy) / (k_optimal * rho_cauchy(x_cauchy, a_optimal, b_optimal));
        if (bern_generate(frac) == 1)
            xs(i) = x_cauchy;
            i = i + 1;
        end
    end
end

