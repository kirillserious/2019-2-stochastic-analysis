%% Задача №1 (а)
% Закон больших чисел
mu = 3;
sigma_sqr = 4;
vecsize = 1000000;

figure, hold on, grid on;
set(gca,'Xscale','log');

ns = 1 : vecsize;
xs = normrnd(mu, sqrt(sigma_sqr), [1, vecsize]);
xs = cumsum(xs) ./ ns;
plot(ns, xs);
plot(ns, mu*ones(1, vecsize));

xlabel('$$n$$', 'interpreter', 'latex', 'FontSize' , 12);
legend('$$\frac{S_n}{n}$$', '$$\mu$$', 'interpreter', 'latex', 'FontSize' , 11);

clear
%% Задача №1 (б)
% Центральная предельная теорема

mu = 3;
sigma_sqr = 4;
n = 10000;
vecsize = 10000;


ss = normrnd(mu, sqrt(sigma_sqr), [n, vecsize]);
ss = sum (ss, 1);
ss = (ss - mu*n) / sqrt(n*sigma_sqr);
numel(ss)
figure(), hold on, grid on;
histogram(ss, 'Normalization', 'pdf');
rho_fcn = @(xs) 1 / sqrt(2*pi) * exp(- (xs.^2) / 2);
plot(-3:0.01:3, rho_fcn(-3:0.01:3), 'LineWidth', 1.5);
xlim([-3, 3]);
% Делаем красиво
xlabel('$$x$$', 'interpreter', 'latex', 'FontSize', 12);
legend('$$\frac{S_n - \mu n}{\sigma \sqrt{n}}$$', '$$\rho_{\mbox{N}(0,\,1)}$$', 'interpreter', 'latex', 'FontSize', 12);

clear
%% Задача №2
% Доверительный интервал матожидания
n = 10000;
mu    = 5;
sigma = 3;

alpha = 0.05;

xs = normrnd(mu, sigma, [1, n]);
ns = 1 : n;

means = cumsum(xs) ./ ns;
vars  = cumsum(xs.^2)./ns - means.^2;
ts    = tinv(1 - alpha/2, 0 : n-1);

top_bounds  = means + (sqrt(vars) ./ sqrt(ns)) .* ts;
down_bounds = means - (sqrt(vars) ./ sqrt(ns)) .* ts;

% Первый элемет резонно NaN
top_bounds  = top_bounds  (2:end);
down_bounds = down_bounds (2:end);
ns = ns(2:end);

figure, hold on, grid on;
set(gca,'Xscale','log');
fill([ns, fliplr(ns)], [top_bounds, fliplr(down_bounds)], [0    0.4470    0.7410], 'FaceAlpha', 0.6);
plot(ns, mu * ones(1, n-1));

xlim([2, n]);
xlabel('$$n$$', 'interpreter', 'latex', 'FontSize', 12);
legend('Доверительный интервал', 'Теоретическое среднее');

% 
% Доверительный интервал дисперсии
%
top_bounds  = (0:n-1) .* vars ./ chi2inv(alpha/2, 0:n-1);       % Финт ушами. Альфа в программе
down_bounds = (0:n-1) .* vars ./ chi2inv((2 - alpha)/2, 0:n-1); % и в теории разные, вот так пересчитались


% Первый элемет резонно NaN
top_bounds  = top_bounds  (2:end);
down_bounds = down_bounds (2:end);


figure, hold on, grid on;
set(gca,'Xscale','log');
fill([ns, fliplr(ns)], [top_bounds, fliplr(down_bounds)], [0    0.4470    0.7410], 'FaceAlpha', 0.6);
plot(ns, sigma^2 * ones(1, n-1));


xlim([10, n]);
xlabel('$$n$$', 'interpreter', 'latex', 'FontSize', 12);
legend('Доверительный интервал', 'Теоретическая дисперсия');

clear
%% Задача № 3 (а)
% Коши закон больших чисел не работает
n = 1000000;

a = 0;
b = 1.5;

xs = cauchy_generate(a, b, 1, n);
xs = cumsum(xs) ./ (1:n);

figure, hold on, grid on;
set(gca,'Xscale','log');
plot(1:n, xs, '.');

xlabel('$$n$$', 'interpreter', 'latex', 'FontSize', 12);
ylabel('$$S_n$$', 'interpreter', 'latex', 'FontSize', 12);

%% Задача № 3 (б)
% Гистограмма распределения частичных сумм распределения Коши

vecsize = 100000;
n = 100;

a = 0;
b = 1.5;

xs = cauchy_generate(a, b, n, vecsize);
xs = sum(xs, 1) ./ n;

figure, hold on, grid on;
histogram(xs,                   ...
        'Normalization', 'pdf', ...
        'BinWidth',      0.1 );

f_inv = @(x) b * tan(pi * (x - 0.5)) + a;
bounds = [f_inv(0.02), f_inv(0.98)];
xlim(bounds);

f     = @(x) 1./(pi * b *(1 + ((x - a)/b).^2));
plot(bounds(1):0.01:bounds(2), f(bounds(1):0.01:bounds(2)), 'LineWidth', 1.5);

xlabel('$$x$$', 'interpreter', 'latex');
legend('Датчик частичных сумм', 'Теоретическая плотность распределения');

%%
a = 0;
b = 1.5;
num = 10000;

x_left = -10;
x_right = 10;

n = linspace(1, num, num);
sns = cauchy(a, b, rand(1, num));
sns = cumsum(sns);
semilogx(n, sns./n, 'b.');
hold on;

plot(n, zeros(1, numel(n)), 'r');
xlabel('n');
ylabel('S_n/n');
legend({'S_n/n', '\mu'}, 'FontSize', 18);
hold off;
