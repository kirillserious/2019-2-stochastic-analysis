function result = pareto_generate(xm, k, varargin)
% Генератор случайных чисел с распределением Парето
     result = xm./(rand(varargin{:}).^(1/k));
end

