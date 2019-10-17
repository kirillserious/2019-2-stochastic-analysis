function [xs, ks] = cantor_generate(vecsize, eps)
% Генератор случайных чисел с распределением канторовой лестницей
%
% Input arguments:
%    vecsize  -- scalar = 1       -- длина случайного вектора
%    eps      -- scalar = 10^(-9) -- погрешность
% Returns:
%    xs -- [1, vecsize] -- случайный вектор
%    ks -- [1, vecsize] -- значения канторовой лестницы в точках,
%                          соответствующих xs
    
    if nargin < 1
        vecsize = 1;
    end
    
    if nargin < 2 || (nargin == 2 && eps > 1)
        N = 20;
    end
    
    if nargin == 2
        N = 1 - ceil(log(eps)/log(3));
    end
    
    % Алгоритм
    bern = bern_generate(0.5, N, vecsize);
    
    mul_vector = transpose(1:N);
    mul_vector = 2 .* (3.^(-mul_vector));
    mul_vector = repmat(mul_vector, 1, vecsize);
   
    xs = bern .* mul_vector;
    xs = sum(xs, 1);
    
    mul_vector = transpose(1:N);
    mul_vector = (2.^(-mul_vector));
    mul_vector = repmat(mul_vector, 1, vecsize);
    
    ks = bern .* mul_vector;
    ks = sum(ks, 1);
end
