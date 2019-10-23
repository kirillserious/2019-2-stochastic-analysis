% Задание 2
%% Задача №1 (а)
%   Строим графики эмпирической и теоретической функций распределения.
%   Считаем уровень значимости по критерию Колмогорова.

N = 1000;    % Размер выборки

figure();
hold on;
grid on;

[cantors, ks] = cantor_generate(N);

% Строим график эмперической функции распределения
[fs, xs] = ecdf(cantors);
stairs(xs, fs);

% Строим график теоритической функции распределения
[sorted_cantors, ind, ~] = unique(cantors);
stairs(sorted_cantors, ks(ind));
    % Тут все по-настоящему, но работает рекурсивно.
    % Используется для красивых графиков.
    %
    % [fs, xs] = devils_staircase(20);
    % plot(xs, fs);
legend({'Эмпирическая функция распределения', 'Канторова лестница'});
xlabel('$$x$$', 'interpreter', 'latex');

% Проверка по критерию Колмогорова
test = kolmogorov_test(cantors, ks);
disp('Уровень значимости: ')
disp(1 - test);

clear cantors xs ks fs;
%% Задача № 1(б)
% Табличка для уровня значимости Колмогорова
n = 1000;     % Число испытаний
m = 1000;     % Размер выборки
alpha = 0.1; % Уровень значимости

success_count = 0;
for i = 1:n
    [xs, ks] = cantor_generate(m);
    test = kolmogorov_test(xs, ks);
    if (1 - test > alpha)
        success_count = success_count + 1;
    end
end

disp('Процент принятия гипотезы:');
disp(success_count / n);

clear

%% Задача №2 (а)
% Считаем уровень значимости по критерию Смирнова для X и (1 - X).

s = 1000;     % Число испытаний
n = 100;      % Размер выборки первой случайной величины
m = 1000;     % Размер выборки второй случайной величины
alpha = 0.05; % Уровень значимости

success_count = 0;
for i = 1:s
    [xs, ~] = cantor_generate(n);
    [ys, ~] = cantor_generate(m);
    ys = 1 - ys;
    
    test = smirnov_test(xs, ys);
    if (1 - test > alpha)
        success_count = success_count + 1;
    end
end

disp('Процент принятия гипотезы:');
disp(success_count / s);
clear

%%
% Построим функции распределения
n = 10000;      % Размер выборки первой случайной величины
m = 10000;     % Размер выборки второй случайной величины

[xs, ~] = cantor_generate(n);
[ys, ~] = cantor_generate(m);
ys = 1 - ys;

figure(), hold on, grid on;
[fs, xs] = ecdf(xs);
stairs(xs, fs, 'LineWidth', 1.5);
[fs, ys] = ecdf(ys);
stairs(ys, fs, 'LineWidth', 1.5);

legend({'$$F_X$$', '$$F_{1 - X}$$'}, ...
        'interpreter', 'latex');
xlabel('$$x$$', 'interpreter', 'latex');

clear
%% Задача №2 (б)
% Считаем уровень значимости по критерию Смирнова для (X | X < 1/3) и (1/3 X).

s = 1000;     % Число испытаний
n = 1000;      % Размер выборки первой случайной величины
m = 1000;     % Размер выборки второй случайной величины
alpha = 0.1; % Уровень значимости

success_count = 0;
for i = 1:s
    [xs, ~] = cantor_generate(n);
    [ys, ~] = cantor_generate(m);

    xs = xs(xs < 1/3);
    ys = ys / 3;

    test = smirnov_test(xs, ys);
    if (1 - test > alpha)
        success_count = success_count + 1;
    end
end

disp('Процент принятия гипотезы:');
disp(success_count / s);
clear

%%
% Построим функции распределения
n = 10000;      % Размер выборки первой случайной величины
m = 10000;     % Размер выборки второй случайной величины

[xs, ~] = cantor_generate(n);
[ys, ~] = cantor_generate(m);
xs = xs(xs < 1/3);
ys = ys / 3;

figure(), hold on, grid on;
[fs, xs] = ecdf(xs);
stairs(xs, fs, 'LineWidth', 1.5);
[fs, ys] = ecdf(ys);
stairs(ys, fs, 'LineWidth', 1.5);

legend({'$$F_{X\,|\,X\in\left[0,\,\frac{1}{3}\right]}$$', '$$F_{\frac{X}{3}}$$'}, ...
        'interpreter', 'latex');
xlabel('$$x$$', 'interpreter', 'latex');

clear
%% Задача №3. Иллюстрируем сходимость мат.ожидания и дисперсии.
left_N  = 100;
right_N = 10000;

figure;
hold on;
grid on;

ns = 1:right_N;
cantors = cantor_generate(right_N);
expecteds = cumsum(cantors) ./ ns;

plot(left_N:right_N, expecteds(left_N:end), 'LineWidth', 1.5);
plot([left_N, right_N], [0.5, 0.5], 'LineWidth', 1.5);
xlabel('$$n$$', 'interpreter', 'latex');
xlim([left_N, right_N]);
legend({'Выборочное среднее', 'Мат. ожидание'});

figure, hold on, grid on;

var = [];
for i = left_N:right_N
   tmp = cantors(1:i);
   var = [var, 1/(i) * (sum((tmp - expecteds(i)).^2))];
end

plot(left_N:right_N, var, 'LineWidth', 1.5);
plot([left_N, right_N], [0.125, 0.125], 'LineWidth', 1.5);
xlabel('$$n$$', 'interpreter', 'latex');
xlim([left_N, right_N]);
legend({'Несмещенная выборочная дисперсия', 'Дисперсия'});

clear

function [f, x] = devils_staircase(recdepth)
% Строит канторову лестницу. Работает рекурсивным образом.
%
% Input arguments:
%     recdepth  - scalar = 10 - глубина рекурсии

    if nargin < 1
        recdepth = 10;
    end
    [f, x] = recursive(0, 1, 0, 1, recdepth);
    f = sort(f);
    x = sort(x);

    function [f, x] = recursive(left_x, right_x, left_f, right_f, recdepth)
        if recdepth == 0
            f = [];
            x = [];
            return
        end
        f_value   = (left_f + right_f)/2;
        tri_value = (right_x - left_x)/3;
        
        [fl, xl] = recursive(left_x, left_x + tri_value, left_f, f_value, recdepth-1);
        [fr, xr] = recursive(right_x-tri_value, right_x, f_value, right_f, recdepth-1);
        
        x = [xl, xr, left_x+tri_value, right_x-tri_value];
        f = [fl, fr, f_value, f_value];
    end
end

