function result = bi_generate(n, p, varargin)
% Генератор случайных чисел с биноминальным распределением
% 
% Input arguments:
%    n        - scalar       - параметр биноминального распределения
%    p        - scalar       - параметр биноминального распределения
%    varargin - scalar cells - размерность случайного тензора
    
    % Проверка на правильный ввод
    if p < 0 || p > 1 
        error('p = %4.2f is out of bounds [0, 1]',p);
    end
    if mod(n, 1) ~= 0
        error('n = %4.2f is not integer',n);
    end
    if n < 1
        error('n = %d is not positive',n);
    end
    
    % Алгоритм
    if numel(varargin) == 0
        bern_matrix = bern_generate(p, n, 1);
        result = sum(bern_matrix);
    else
        if numel(varargin) == 1
            bern_matrix = bern_generate(p, varargin{:}, varargin{:}, n);
            result = sum(bern_matrix, 3);
        else
            dimention = numel(varargin) + 1;
            bern_matrix = bern_generate(p, varargin{:}, n);
            result = sum(bern_matrix, dimention);
        end
    end
end

