function result = kolmogorov_fcn (x)
% Вычисляет значение функции распределения Колмогорова в заданной точке
% Input arguments:
%    x -- scalar
    
    if x < 0.17
    % Предел вычислительной мощности. Число порядка 10^(-9)
        result = 0;
        return
    end
    
    ks = 1 : 100;
    result = 1 + 2 * sum( ...
            (-1).^ks .* exp(-2 * (ks.^2) .* (x)^2) ...
        );
end
