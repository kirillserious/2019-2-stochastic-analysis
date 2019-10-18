function p_value = smirnov_test(xs, ys)
% Считает p-значение по критерию Смирнова
% Input arguments:
%    xs -- [1, N] -- выборка из первого распределения
%    ys -- [1, M] -- выборка из второго распределения

    n = numel(xs); % Запоминем размер выборки                                     
    m = numel(ys); %
    
    xs = sort(xs); % Сортируем выборки
    ys = sort(ys); %
    
    xfs = (1 : numel(xs)) / numel(xs); % Считаем эмперические функции
    [xs, ind, ~] = unique(xs, 'last'); % распределения
    xfs = xfs(ind);                    %
                                       %
    yfs = (1 : numel(ys)) / numel(ys); %
    [ys, ind, ~] = unique(ys, 'last'); %
    yfs = yfs(ind);                    %
    
    % Находим индексы ближайших слева элементов в соседней выборке
    xs = [0, xs];
    ys = [0, ys];
    pifagore_table = repmat(xs, numel(ys), 1) - repmat(ys', 1, numel(xs));
    pifagore_table(pifagore_table < 0) = 1;
    [~, ind_for_y] = min(pifagore_table, [], 1);
    
    pifagore_table = repmat(ys, numel(xs), 1) - repmat(xs', 1, numel(ys));
    pifagore_table(pifagore_table < 0) = 1;
    [~, ind_for_x] = min(pifagore_table, [], 1);
    
    xfs = [0, xfs];                             % Считаем статистику
    yfs = [0, yfs];                             % Смирнова
    d = max(                                ... %
            max(abs(yfs - xfs(ind_for_x))), ... %
            max(abs(xfs - yfs(ind_for_y)))  ... %
            );                                  %
                                        
    p_value = kolmogorov_fcn(sqrt((n * m) / (n + m)) * d); % Считаем ответ
end


 