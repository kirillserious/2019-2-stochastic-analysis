clear;
squared_sigma = 1;
lambda = 1;
n = 10;
t0 = 0;
t1 = 1;
eps = 1e-3;

x0 = randn(1) * sqrt(squared_sigma); 
x1 = randn(1) * sqrt(squared_sigma * (1 - exp(-2*lambda*t1))) + x0 * exp(-lambda * t1);
[xs, times] = ornstein_uhlenbeck(t0, t1, x0, x1, squared_sigma, lambda, eps);

%% 	Gauss
n = numel(xs);

sigma_v = 0.4;                    % v - случайный шум
v = normrnd(0, sigma_v, [1, n]);  %

ys = xs + v;

a = exp(-lambda*(times(2) - times(1)));
q = squared_sigma*(1 - a^2);  % q, h - временные переменные, 
                              % не несут смысловой нагрузки   

results = zeros(1, n);
results(1) = ys(1);

rs = zeros(1, n);
rs(1) = sigma_v^2;
for k = 2 : n
    x = a*results(k - 1);
    r = (a^2)*rs(k -1) + q;    
    h = r/(r + sigma_v^2);
    rs(k) = (1 - h)*r;
    results(k) = (1 - h)*x + h*ys(k);
end 

figure, hold on, grid on;

p1 = plot(times, ys,'.');
p1.Color = [0.9290, 0.6940, 0.1250, 0.1];

object = fill(                                                     ...
              [times, fliplr(times)],                              ...
              [results + 3*sqrt(rs), fliplr(results -3*sqrt(rs))], ...
              [0    0.4470    0.7410],                             ... 
              'FaceAlpha', 0.2                                     ...
         );
     
p2 = plot(times, xs, 'LineWidth', 1.5);
p2.Color = [0.85, 0.325, 0.0980];

legend('Входные значения', 'Доверительный интервал', 'Настоящие значения');
xlabel('$$t$$', 'interpreter', 'latex');
ylabel('$$W$$', 'interpreter', 'latex');
%% Cauchy

sigma_v = 10;
n = length(xs);
v = cauchy_generate(0, 1, 1, n);
ys = xs + v;

a = exp(-lambda*(times(2) - times(1)));
q = squared_sigma*(1 - a^2);
results = zeros(1, n);
rs = zeros(1, n);
rs(1) = squared_sigma;
for k = 2 : n
    x = a*results(k - 1);
    r = (a^2)*rs(k -1) + q;
    h = r/(r + sigma_v);
    rs(k) = (1 - h)*r;
    results(k) = (1 - h)*x + h*ys(k);
end 

figure, hold on, grid on;

p1 = plot(times, ys,'.');
p1.Color = [0.9290, 0.6940, 0.1250, 0.5];

object = fill(                                                     ...
              [times, fliplr(times)],                              ...
              [results + 3*sqrt(rs), fliplr(results -3*sqrt(rs))], ...
              [0    0.4470    0.7410],                             ... 
              'FaceAlpha', 0.2                                     ...
         );
     
p2 = plot(times, xs, 'LineWidth', 1.5);
p2.Color = [0.85, 0.325, 0.0980];

legend('Входные значения', 'Доверительный интервал', 'Настоящие значения');
xlabel('$$t$$', 'interpreter', 'latex');
ylabel('$$W$$', 'interpreter', 'latex');
ylim([-30, 30])