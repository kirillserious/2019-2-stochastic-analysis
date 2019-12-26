function xs = cauchy_generate(a, b, varargin)
    xs = b * tan(pi * (rand(varargin{:}) - 0.5)) + a;
end

