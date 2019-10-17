function p_value = kolmogorov_test(emps, theorys, mode)
% Критерий Колмогорова. Считает p-значение.
%
% Input arguments:
%    emps    -- [1, N]          --   эмперическое распределение
%    theorys -- [1, N]          --   теоретическое распределение в соотв.
%                                  точках
%    mode    -- str = 'default' --   режим 
    if nargin < 3
        mode = 'default';
    end
    
    n = numel(emps); % Запомнили размер выборки
   
    [emps, ind] = sort(emps); % Сортируем выборки
    theorys = theorys(ind);   %

    fs = (1 : numel(emps)) / numel(emps);  % Строим эмп. ф-ию распределения
    [emps, ind, ~] = unique(emps, 'last'); % и приводим все в общий вид
    theorys = theorys(ind);                %
    fs = fs(ind);                          %
    
    
    differences = abs(theorys - fs);  % Cчитаем статистику Колмогорова D
    [D, ind] = max(differences);      %
    
    if strcmp(mode, 'draw')
    % Рисуем разность эмп. и теор. ф-ий распределения
        figure();
        hold on, grid on;
        plot(emps, differences);
        plot(emps(ind), differences(ind), '*');   %
        xlabel('$$x$$', 'interpreter', 'latex');
        legend('$$|F_n(x) - K(x)|$$', ...
            '$$\max\limits_{x}|F_n(x) - K(x)|$$', ...
            'interpreter', 'latex');
    end
    
    p_value = kolmogorov_fcn(sqrt(n) * D);
    
    if strcmp(mode, 'draw')
        % Рисуем функцию распределения Колмогорова и полученное значение
        % (есть цикл)
        figure();
        hold on, grid on;
        xs = 0:0.01:3;
        fs = [];
        for i = xs
            fs = [fs, kolmogorov_fcn(i)];
        end
        plot(xs, fs);
        plot(sqrt(n)*D, p_value, '*');
        xlabel('$$x$$', 'interpreter', 'latex');
        legend('Kolmogorov distribution function $F_K$',...
            '$$F_K(\sqrt{n}D_n)$$', 'interpreter', 'latex');
    end     
end