function result = exp_generate(lambda, varargin)
% Генератор случайных величин с экспоненциальным распределением
% Input arguments:
%    lambda   -- scalar       -- параметр распределения
%    varargin -- scalar cells -- размерность случайного тензора
    uniform = rand(varargin{:});
    result = -log(1 - uniform) / lambda;
end

