%% Задача №1. Строим графики эмпирической и теоретической функций распределения.
N = 10000;    % Размер выборки

figure();
hold on;
grid on;

cantors = cantor_generate(N);
[fs, xs] = ecdf(cantors);
plot(xs, fs);

[fs, xs] = devils_staircase();
plot(xs, fs);

legend({'Эмпирическая функция распределения', 'Канторова лестница'});
xlabel('$$x$$', 'interpreter', 'latex');

clear cantors xs fs;
%% Задача №3. Иллюстрируем сходимость мат.ожидания и дисперсии.
left_N  = 50000;
right_N = 100000;

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