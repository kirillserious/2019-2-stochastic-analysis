% Задание №7
%% Задача 1 (а)
% Рисуем поверхность

task_fcn = @(xs, ys) xs.^3 .* sin(1./xs) + 10 * xs .* ys.^4 .* cos(1./ys);

xs = linspace(-1, 1);
ys = linspace(-1, 1);

[xs, ys] = meshgrid(xs, ys);
zs = task_fcn(xs, ys);
zs(xs.^2 + ys.^2 > 1) = NaN;

surf(xs, ys, zs);
xlabel('$$x_1$$', 'interpreter', 'latex');
ylabel('$$x_2$$', 'interpreter', 'latex');
zlabel('$$f$$', 'interpreter', 'latex');

clear


%% Задача 1 (б)
% Ищем минимум функции методом случайного поиска
p = 0.99;    % Уровень доверия
n = 100000;  % Число генераций


task_fcn = @(xs, ys) xs.^3 .* sin(1./xs) + 10 * xs .* ys.^4 .* cos(1./ys);

[xs, ys] = uniform_generate(1, n);

disp('Минимум:');
disp(min(task_fcn(xs, ys)));

disp('Погрешность:');
disp(22.17 * sqrt(p / n));

clear

%% Задание 1 (в)
% Погрешность
n = 1000;

task_fcn = @(xs, ys) xs.^3 .* sin(1./xs) + 10 * xs .* ys.^4 .* cos(1./ys);
true_min = -1.2885;
true_epss = zeros(1, n);


for i = 1:1:n
    [xs, ys] = uniform_generate(1, i);
    true_epss(i) = min(task_fcn(xs, ys));
end

figure, hold on, grid on;
set(gca,'Xscale','log');
plot(1:1:n, true_epss(1:1:n) - true_min);

plot(1:1:n, 22.17*sqrt(0.99./(1:1:n)));
ylim([0 5]);

xlabel('$$n$$', 'interpreter', 'latex');
ylabel('$$\varepsilon$$', 'interpreter', 'latex');
legend('Практическая погрешность', 'Теоретическая погрешность');
clear
%% Задание 2 (а)
% Рисуем поверхность

task_fcn = @(xs, ys) (xs - 1).^2 + 100.*(ys - xs.^2).^2;

xs = linspace(-3, 3);
ys = linspace(-3, 3);

[xs, ys] = meshgrid(xs, ys);
zs = task_fcn(xs, ys);

surf(xs, ys, zs);
alpha 0.8
xlabel('$$x_1$$', 'interpreter', 'latex');
ylabel('$$x_2$$', 'interpreter', 'latex');
zlabel('$$g$$', 'interpreter', 'latex');

clear


%% Задача 2 (б)
% Метод отжига
n = 100;
mins = zeros(1, n);
for i = 1:n
    mins(i) = annealing_method(1000);
end

disp('Медиана:');
disp(median(mins));

disp('Минимум:');
disp(min(mins));

clear

function [xs, ys] = uniform_generate(varargin)
    rs   = sqrt(rand(varargin{:}));
    phis = 2*pi*rand(varargin{:});
    
    xs = rs .* cos(phis);
    ys = rs .* sin(phis);
end

function min = annealing_method (n)
    point = [0 0];
    temp = 1;

    task_fcn = @(xs, ys) (xs - 1).^2 + 100.*(ys - xs.^2).^2;

    % tmp_count = 0; % Одна из метрик качества работы алгоритма
    
    min = inf;
    for i = 1 : n
        maybe = randn(1, 2) .* sqrt(temp) + point;  % Вариант подбора новой точки
        value = task_fcn(maybe(1), maybe(2));
        if value >= min
            prob = exp((min-value)/temp);
            if rand(1, 1) < prob 
                point = maybe;
                min   = value;
            else
                % tmp_count = tmp_count + 1;
            end
        else
            point = maybe;
            min   = value;
        end
        temp = 0.99*temp; % Вариант изменения температуры
    end
    
    % disp(tmp_count)
end