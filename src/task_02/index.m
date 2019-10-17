% Задание 2
%% Задача №1
%   Строим графики эмпирической и теоретической функций распределения.
%   Считаем уровень значимости по критерию Колмогорова.

N = 10000;    % Размер выборки

figure();
hold on;
grid on;

[cantors, ks] = cantor_generate(N);

% Строим график имперической функции распределения
[fs, xs] = ecdf(cantors);
plot(xs, fs);

% Строим график теоритической функции распределения
[sorted_cantors, ind, ~] = unique(cantors);
plot(sorted_cantors, ks(ind));
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

%% Задача №2 (а)
% Считаем уровень значимости по критерию Смирнова для X и (1 - X).

n = 100;  % Размер выборки первой случайной величины
m = 1000; % Размер выборки второй случайной величины

[xs, ~] = cantor_generate(n);
[ys, ~] = cantor_generate(m);

test = smirnov_test(xs, ys);
disp('Уровень значимости:');
disp(1 - test);

clear xs ys n m;
%% Задача №2 (б)
% Считаем уровень значимости по критерию Смирнова для (X | X < 1/3) и (1/3 X).

n = 100;  % Размер выборки первой случайной величины
m = 1000; % Размер выборки второй случайной величины

[xs, ~] = cantor_generate(n);
[ys, ~] = cantor_generate(m);

xs = xs(xs < 1/3);
ys = ys / 3;

test = smirnov_test(xs, ys);
disp('Уровень значимости:');
disp(1 - test);

clear xs ys n m;
%% Задача №3. Иллюстрируем сходимость мат.ожидания и дисперсии.
left_N  = 50000;
right_N = 1000;

figure;
hold on;
grid on;

ns = 1:right_N;
cantors = cantor_generate(right_N);
expecteds = cumsum(cantors) ./ ns;

plot(left_N:right_N, expecteds(left_N:end));
plot([left_N, right_N], [0.5, 0.5]);
xlabel('$$n$$', 'interpreter', 'latex');
legend({'$$E\,[X] = \frac{X_1 + \ldots + X_n}{n}$$', '$$E\,[X] = \frac12$$'}, 'interpreter', 'latex');

clear ns cantors expecteds;

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

