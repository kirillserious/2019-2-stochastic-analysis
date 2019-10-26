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