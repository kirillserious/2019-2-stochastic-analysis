% Задание 3
%% Задача 1 (а)
% Строим гистограмму распределения
n      = 100000;  % Размер выборки
lambda = 2;      % Параметр распределения

xs = exp_generate(lambda, 1, n);

figure(), hold on, grid on;
histogram(xs, 'Normalization', 'pdf', 'BinWidth', 0.2);

% Двигаем график правильно
alpha = 0.0005;  % Сколько можно не включать
f_inv = @(p) -log(1 - p) / lambda;
r_bound = f_inv(1 - alpha);
xlim([0 r_bound]);

rho = @(x) lambda * exp(-lambda*x);
plot(0:0.01:r_bound, rho(0:0.01:r_bound));

% Делаем красиво
xlabel('$$x$$', 'interpreter', 'latex');
legend('Результат датчика', 'Теоретическая плотность распределения');

clear
%% Задача 1 (б)
% Свойство отсутствия памяти
n      = 1000;  % Размер выборки
lambda = 1.5;    % Параметр распределения
m      = 1;      % Сдвиг

xs = exp_generate(lambda, 1, n);

figure(), hold on, grid on;
histogram(xs, 'Normalization', 'cdf', 'BinWidth', 0.2, 'EdgeAlpha', 0.7);

xs = xs(xs > m) - m;
histogram(xs, 'Normalization', 'cdf', 'BinWidth', 0.2, 'EdgeAlpha', 0.7);

% Двигаем график правильно
alpha = 0.0005;  % Сколько можно не включать
f_inv = @(p) -log(1 - p) / lambda;
r_bound = f_inv(1 - alpha);
xlim([0 r_bound]);

% Делаем графики красивыми
xlabel('$$x$$', 'interpreter', 'latex');
legend('$$\mbox{P}(X \leq x)$$',                 ...
       '$$\mbox{P}(X \leq x + m\,|\,X \geq m)$$', ...
        'interpreter', 'latex');
    
clear;
%% Задача 1 (в)
% Строим распределение минимума экспоненциальным случайных величин

lambda = 0.1; % Раз уж реализована функция для матрицы с одной лямбдой
n = 10000;    % Размер выборки
m = 10;       % Число эксп. с. в. в минимуме

xs = exp_generate(lambda, m, n);
xs = min(xs);

figure(), hold on, grid on;
histogram(xs, 'Normalization', 'pdf', 'BinWidth', 0.2);

% Двигаем график правильно
alpha = 0.0005;  % Сколько можно не включать
f_inv = @(p) -log(1 - p) / (m * lambda);
r_bound = f_inv(1 - alpha);
xlim([0 r_bound]);

rho = @(x) m * lambda * exp(-m*lambda*x);
plot(0:0.01:r_bound, rho(0:0.01:r_bound));

% Делаем красиво
xlabel('$$x$$', 'interpreter', 'latex');
legend('Результат датчика', 'Теоретическая плотность распределения');

clear

%% Задача 2
% Строим гистограмму распределения Пуассона
n = 10000;   % Размер выборки
lambda = 10; % Параметр распределения

xs = poisson_generate(lambda, n);

figure(), hold on, grid on;
histogram(xs, 'Normalization', 'probability');

% Двигаем график правильно
r_bound = ceil(lambda + 3*lambda);
xlim([0 r_bound]);

prob_fcn = @(ks) (exp(-lambda) * lambda .^ ks) ./ factorial(ks);
plot(0:r_bound, prob_fcn(0:r_bound), '*');

% Делаем красиво
xlabel('$$k$$', 'interpreter', 'latex');
legend('Результат датчика', 'Теоретический результат');

clear
%% Задача 3
% Строим распределение Пуассона, как приближение биномиальным
n = 100;
lambda = 1;

bin_n = 1000 * lambda;
bin_p = lambda / bin_n;

xs = bi_generate(bin_n, bin_p, 1, n);

figure(), hold on, grid on;
histogram(xs, 'Normalization', 'probability');

% Двигаем график правильно
r_bound = ceil(lambda + 3*lambda);
xlim([0 r_bound]);

prob_fcn = @(ks) (exp(-lambda) * lambda .^ ks) ./ factorial(ks);
plot(0:r_bound, prob_fcn(0:r_bound), '*');

% Делаем красиво
xlabel('$$k$$', 'interpreter', 'latex');
legend('Результат датчика', 'Теоретический результат');

[chisquare, freedom_degrees, p_value] = chisquare_test(xs, prob_fcn);

disp('Хи-квадрат:');
disp(chisquare);
disp('Степеней свободы:');
disp(freedom_degrees);
disp('Уровень значимости:');
disp(1 - p_value);

clear
%% Задача №4
% Строим гистограмму стандартного нормального распределения
n = 10000; % Размер выборки

xs = stdnormal_generate(1, n);

figure(), hold on, grid on;
histogram(xs, 'Normalization', 'pdf');
rho_fcn = @(xs) 1 / sqrt(2*pi) * exp(- (xs.^2) / 2);
plot(-3:0.01:3, rho_fcn(-3:0.01:3));
xlim([-3, 3]);
% Делаем красиво
xlabel('$$k$$', 'interpreter', 'latex');
legend('Результат датчика', 'Теоретический результат');

disp('Проверка равенства мат. ожиданий');
[t, fd, p] = student_test(xs, 0);
disp('t-статистика:');
disp(t);
disp('Степеней свободы:');
disp(fd);
disp('Уровень значимости:');
disp(1 - p);

disp('Проверка равенства дисперсий');
[f, fd, p] = fisher_test(xs, [-1, 1]);
disp('f-статистика:');
disp(f);
disp('Степеней свободы:');
disp(fd);
disp('Уровень значимости:');
disp(1 - p);
