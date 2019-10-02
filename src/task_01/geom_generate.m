function result = geom_generate (p, varargin)
% Генерирует геометрическое распределение
% До N = 1000 (примерно до p > 0.005)!
% 
% Input arguments:
%     p        - scalar       - параметр распределения
%     varargin - scalar cells - размер тензора

    % Проверим начальные данные
    if p < 0 || p > 1
        error('p = %4.2f is out of bounds [0, 1]',p)
    end
    
    % M - число до которого алгоритм работает
    N = 1000;
    
    % Алгоритм
    if numel(varargin) == 0
        result = bern_generate(p, N, 1);
        result = find(result, 1);
        if isempty(result)
            result = 100;
        end
    else
        if numel(varargin) == 1
            result = bern_generate(p, varargin{:}, varargin{:}, N);
            result = ones(size(result)) & cumsum(result, 3) == 0;
            result = sum(result, 3);
        else
            dimention = numel(varargin) + 1;
            result = bern_generate(p, varargin{:}, N);
            result = ones(size(result)) & cumsum(result, dimention) == 0;
            result = sum(result, dimention);
        end
    end
end

