%% Задача 1
% Строим распределение Коши
n = 1000;
a = 2;
b = 0.25;

xs = cauchy_generate(a, b, 1, n);
figure(), hold on, grid on;
histogram(xs,                   ...
        'Normalization', 'pdf', ...
        'BinWidth',      0.1 );

f_inv = @(x) b * tan(pi * (x - 0.5)) + a;
bounds = [f_inv(0.02), f_inv(0.98)];
xlim(bounds);

f     = @(x) 1./(pi * b *(1 + ((x - a)/b).^2));
plot(bounds(1):0.01:bounds(2), f(bounds(1):0.01:bounds(2)), 'LineWidth', 1.5);

xlabel('$$x$$', 'interpreter', 'latex');
legend('Результат датчика', 'Теоретическая плотность распределения');

clear

%% Задача №2 (a)
% Метод фон Нейнама. Гистограмма
xs = von_neumann(1000);

% Гистограмма
figure(), hold on, grid on;
histogram(xs,                   ...
        'Normalization', 'pdf', ...
        'BinWidth',      0.1 );
rho_fcn = @(xs) 1 / sqrt(2*pi) * exp(- (xs.^2) / 2);
plot(-3:0.01:3, rho_fcn(-3:0.01:3), 'LineWidth', 1.5);
xlim([-3, 3]);
% Делаем красиво
xlabel('$$x$$', 'interpreter', 'latex');
legend('Результат датчика', 'Теоретический результат');

clear
%% Задача №2 (б)
% Метод фон Неймана. НормПробабилитиПлот
figure, hold on, grid on;
xs = von_neumann(1000);
normplot(xs)

clear
%% Задача № 3
% Сравнение скоростей работы

figure, hold on, grid on

max_n = 1000;
times = zeros(1, max_n);
for i = 1:max_n
    tic;
    stdnormal_generate(1, i);
    times(i) = toc;
end

plot(1:max_n, times);

for i = 1:max_n
    tic;
    von_neumann(i);
    times(i) = toc;
end

plot(1:max_n, times);


xlabel('$n$', 'interpreter', 'latex');
ylabel('$t,\,c$', 'interpreter', 'latex');
legend('Моделирование парами', 'Метод фон Неймана');
clear