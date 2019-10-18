% Задание 3
%% Задача 1 (а)
% Строим гистограмму распределения
n      = 10000;  % Размер выборки
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
n      = 10000;  % Размер выборки
lambda = 0.5;    % Параметр распределения
m      = 1;      % Сдвиг

xs = exp_generate(lambda, 1, n);

figure(), hold on, grid on;
[fs, ys] = ecdf(xs);
plot(ys, fs);

xs = xs(xs > m) - m;
[fs, ys] = ecdf(xs);
plot(ys, fs);

% Двигаем график правильно
alpha = 0.0005;  % Сколько можно не включать
f_inv = @(p) -log(1 - p) / lambda;
r_bound = f_inv(1 - alpha);
xlim([0 r_bound]);