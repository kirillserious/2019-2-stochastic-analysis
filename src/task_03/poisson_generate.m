function results = poisson_generate(lambda, vecsize)
% Датчик случайной величины с распределением Пуассона с параметром \lambda
%
% Input arguments:
%    lambda  -- scalar     -- параметр распределения
%    vecsize -- scalar = 1 -- размер случайного вектора

    if nargin < 2
        vecsize = 1;
    end
    
    % Посчитаем максимальное число экспериментов, до которого будем
    % суммировать по правилу трёх сигм, и прибавим ещё немного.
    n = ceil(lambda + 3*lambda + 3*lambda);
    
    results = exp_generate(1, n, vecsize);
    results = cumsum(results, 1);
    results = results < lambda;
    results = sum(results, 1);
end

