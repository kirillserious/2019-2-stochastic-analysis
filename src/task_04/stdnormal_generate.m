function xs = stdnormal_generate(varargin)
% Генератор случайных величин со стандартным нормальным распределением
% Input arguments:
%    varargin -- scalar cells -- размерность случайного тензора

    xs = sqrt(2 * exp_generate(1, varargin{:})) .* sin(2*pi*rand(varargin{:}));
end

