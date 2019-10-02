% Решение задачи
%% Задача 1. Строим биномиальное распределение: практическое и теоретическое.

n = 50;    % Количество экспирементов
p = 0.3;   % Вероятность "успеха"
N = 100000; % Размер выборки

figure();
hold on;
grid on;

% Рисуем практическую гистограмму распределения
bi_results     = bi_generate(n, p, 1, N);
practical_plot = histogram(bi_results, 'Normalization', 'probability');
clear bi_results;

% Рисуем теоритическую кривую распределения
ks          = 0:n;
results     = bin_coefficient(n, ks) .* ( p ).^ks .* ( 1 - p ).^(n-ks);
theory_plot = plot(ks, results, '*');
clear ks results;

% Делаем графики красивыми
title(sprintf(...
        'Распределение случайной величины X~Bi (%d, %4.2f)', n, p));
xlabel('k');
ylabel('P(X = k)');
legend([practical_plot theory_plot], ...
        {'Результат датчика', 'Теоретический результат'});
clear practical_plot theory_plot;

%% Задача 2. Строим геометрическое распределение: практическое и теоретическое.

p = 0.3;   % Вероятность "успеха"
N = 100000; % Размер выборки

figure();
hold on;
grid on;

% Рисуем практическую гистограмму распределения
geom_results   = geom_generate(p, 1, N);
practical_plot = histogram(geom_results, 'Normalization', 'probability');
last_bound = max(geom_results);
clear geom_results;

% Рисуем теоритическую кривую распределения
ks          = 0:last_bound;
results     = ( p ) * ( 1 - p ).^ks;
theory_plot = plot(ks, results, '*');
clear ks results;

% Делаем графики красивыми
title(sprintf(...
        'Распределение случайной величины X~Geom (%4.2f)', p));
xlabel('k');
ylabel('P(X = k)');
legend([practical_plot theory_plot], ...
        {'Результат датчика', 'Теоретический результат'});    

    
%% Задача 2. Проверка свойства отсутствия памяти.

p = 0.2;    % Вероятность "успеха"
m = 10;     % "Сдвиг" памяти 
N = 10000;  % Размер выборки

figure();
hold on;
grid on;

geom_results = geom_generate(p, 1, N);

usual_plot  = histogram(geom_results, 'Normalization', 'probability');
offset_plot = histogram(geom_results(geom_results >= m), 'Normalization', 'probability');
clear geom_results;

title(sprintf('Отсутствие памяти у X~Geom(%4.2f), m=%d', p, m));
xlabel('n');
legend([usual_plot, offset_plot], {'P( X=n )', 'P( X=n+m | X \geq m )'});
clear usual_plot offset_plot;

%% Задача 3. Строим траекторию процесса игры в Орлянку.
n = 1000;    % Число подбрасываний монет
p = 0.5;     % Вероятность того, что выпал <<орел>>

figure();
grid on;
hold on;

results = bern_generate(p, 1, n);
results = 2*(results - 0.5);          % [0, 1] -> [-1, +1]
results = cumsum(results) / sqrt(n);

plot(1:n, results);
clear ts results;

title('Поведение нормированной суммы Y игры в Орлянку');
legend('$$Y(i) = \frac{X_1 +\ldots+ X_i}{\sqrt{n}}$$', 'interpreter', 'latex');
xlabel('i');
ylabel('Y');

function result = bin_coefficient(n, ks)
    % Биномиальный коэффициент C_n^k
    % Input arguments:
    %    n - scalar
    %    k - [1, N]
    
    result = factorial(n) ./ factorial(ks) ./ factorial(n - ks);
end