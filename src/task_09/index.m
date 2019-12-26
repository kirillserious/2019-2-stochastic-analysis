%% Задание 1 (а)
t0 = 0;
t1 = 1;
x0 = 0;
x1 = randn(1);
alpha = 0.3;
eps = 0.0001;

figure, hold on, grid on;
% Доверительный интервал
object = fill(                                                 ...
              [0:0.001:1, fliplr(0:0.001:1)],                  ...
              [3*sqrt(0:0.001:1), fliplr(-3*sqrt(0:0.001:1))], ...
              [0    0.4470    0.7410],                         ... 
              'FaceAlpha', 0.5                                 ...
         );


[xs, times] = weiner(t0, t1, x0, x1, alpha, eps);
plot(times, xs, '.');

xlabel('t',    'interpreter', 'latex');
ylabel('W(t)', 'interpreter', 'latex');
legend([object], ' Доверительный интервал');
clear
%% Задание 1 (б)
t0 = 0;
t1 = 1;
x0 = 0;
alpha = 0.3;
eps = 0.0001;

figure, hold on, grid on;

% Доверительный интервал
object = fill(                                                 ...
              [0:0.001:1, fliplr(0:0.001:1)],                  ...
              [3*sqrt(0:0.001:1), fliplr(-3*sqrt(0:0.001:1))], ...
              [0    0.4470    0.7410],                         ... 
              'FaceAlpha', 0.5                                 ...
         );

for i = 1:50
    x1 = randn(1);
    [xs, times] = weiner(t0, t1, x0, x1, alpha, eps);
    plot(times, xs);
end



xlabel('t',    'interpreter', 'latex')
ylabel('W(t)', 'interpreter', 'latex')
legend([object], ' Доверительный интервал');
clear;

%% Задание 2 (а)
squared_sigma = 3;
lambda = 20;
eps = 0.00001;
t0 = 0;
t1 = 1;

figure, hold on, grid on;

x0 = randn(1) * sqrt(squared_sigma); 
x1 = randn(1) * sqrt(squared_sigma * (1 - exp(-2*lambda*t1))) + x0 * exp(-lambda * t1);

[xs, times] = ornstein_uhlenbeck(t0, t1, x0, x1, squared_sigma, lambda, eps);
    

% Доверительный интервал
top_bound    = x0.*exp(-lambda.*[0:0.001:1]) + 3.*sqrt(squared_sigma.*(1 - exp(-2.*lambda.*[0:0.001:1])));
bottom_bound = x0.*exp(-lambda.*[0:0.001:1]) - 3.*sqrt(squared_sigma.*(1 - exp(-2.*lambda.*[0:0.001:1])));

object = fill(                                    ...
              [0:0.001:1, fliplr(0:0.001:1)],     ...
              [top_bound, fliplr(bottom_bound)],  ...
              [0    0.4470    0.7410],            ... 
              'FaceAlpha', 0.5                    ...
         );

plot(times, xs, '.');     
     
xlabel('t',    'interpreter', 'latex');
ylabel('W(t)', 'interpreter', 'latex');
legend([object], ' Доверительный интервал');

clear;

%% Задание 2 (б)
n = 50;
squared_sigma = 3;
lambda = 20;
eps = 0.001;
t0 = 0;
t1 = 1;

figure, hold on, grid on;

% Доверительный интервал
top_bound    =  3 + 3.*sqrt(squared_sigma.*(1 - exp(-2.*lambda.*[0:0.001:1])));
bottom_bound = -3 - 3.*sqrt(squared_sigma.*(1 - exp(-2.*lambda.*[0:0.001:1])));

object = fill(                                    ...
              [0:0.001:1, fliplr(0:0.001:1)],     ...
              [top_bound, fliplr(bottom_bound)],  ...
              [0    0.4470    0.7410],            ... 
              'FaceAlpha', 0.5                    ...
         );


for i = 1 : n
    x0 = randn(1) * sqrt(squared_sigma); 
    x1 = randn(1) * sqrt(squared_sigma * (1 - exp(-2*lambda*t1))) + x0 * exp(-lambda * t1);

    [xs, times] = ornstein_uhlenbeck(t0, t1, x0, x1, squared_sigma, lambda, eps);
    
    plot(times, xs);
end

xlabel('t',    'interpreter', 'latex');
ylabel('W(t)', 'interpreter', 'latex');
legend([object], ' Доверительный интервал');

clear;
