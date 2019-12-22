%% Задание 1 (а)
t0 = 0;
t1 = 1;
x0 = 0;
x1 = randn(1);
alpha = 0.3;
eps = 0.0001;
[xs, times] = weiner(t0, t1, x0, x1, alpha, eps);
plot(times, xs, '.');
grid on;
xlabel('t',    'interpreter', 'latex')
ylabel('W(t)', 'interpreter', 'latex')

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
              'FaceAlpha', 0.6                                 ...
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