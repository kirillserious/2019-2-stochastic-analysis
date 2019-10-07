%% Задача №1. Строим графики эмпирической и теоретической функций распределения.
N = 100;    % Размер выборки

figure();
hold on;
grid on;

cantor_vector = cantor_generate(N);
[f, x] = ecdf(cantor_vector);
plot(x, f);

[f, x] = devils_staircase();
plot(x, f);

legend({'Эмпирическая функция распределения', 'Лестница Кантора'});
xlabel('$$x$$', 'interpreter', 'latex');


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