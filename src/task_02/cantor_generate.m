function result = cantor_generate(vecsize)
% Генератор случайных чисел с распределением канторовой лестницей
% ! Погрешность eps = 10^-9 (N = 20)
%
% Input arguments:
%    vecsize  - scalar = 1   - длина случайного вектора
    
    if nargin < 1
        vecsize = 1;
    end

    % Алгоритм
    N = 20;
    
    mul_vector = transpose(1:N);
    mul_vector = 2 .* (3.^(-mul_vector));
    mul_vector = repmat(mul_vector, 1, vecsize);
    
    result = bern_generate(0.5, N, vecsize);
    result = result .* mul_vector;
    result = sum(result, 1);
end
