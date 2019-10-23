function result = bern_generate(p, varargin)
% Генератор случайных чисел с распределением Бернулли
% 
% Input arguments:
%    p        - scalar       - параметр распределения Бернулли
%    varargin - scalar cells - размерность случайного тензора

    if p < 0 || p > 1
        error('p = %4.2f is out of bounds [0, 1]',p)
    end
    
    result = rand(varargin{:}) < p;
end

