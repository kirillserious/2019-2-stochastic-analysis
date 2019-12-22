%% Рисуем сетку

n = 20;

h = 2/n;
xs = -1:h:1;
ys = -1:h:1;

[X,Y] = meshgrid(xs,ys);
bounds_mat = (((X+h).^2+Y.^2 > 1) | ((X-h).^2+Y.^2 > 1) | (X.^2+(Y+h).^2 > 1) | (X.^2+(Y-h).^2 > 1)) & (X.^2+Y.^2 <= 1);
location = zeros(length(xs));
location(X.^2+Y.^2 > 1) = NaN;
location = location + bounds_mat;

[in_xs, in_ys]       = find(location == 0);
[bound_xs, bound_ys] = find(location == 1);


figure, hold on, grid on;
plot(xs(in_xs),    ys(in_ys),    '*');
plot(xs(bound_xs), ys(bound_ys), '*');

xxx = linspace(-1,1,1000);
plot([xxx, NaN, xxx], [sqrt(1-xxx.^2), NaN, -sqrt(1-xxx.^2)]);
 
xlim([-1.05 1.1]);
ylim([-1.05 1.1]);
xlabel('$$x$$', 'interpreter', 'latex');
ylabel('$$y$$', 'interpreter', 'latex');
legend('Внутренние точки','Граничные точки', 'Граница множества');

clear


%% Рисуем аналитическое решение
n = 20;

h = 2/n;
xs = -1:h:1;
ys = -1:h:1;

f_fcn = @(xs, ys) xs.^2 - ys.^2;


[X,Y] = meshgrid(xs,ys);

figure;

surf(X, Y, f_fcn(X, Y));
xlabel('$$x$$', 'interpreter', 'latex');
ylabel('$$y$$', 'interpreter', 'latex');
zlabel('$$f$$', 'interpreter', 'latex');
clear

%% Численное решение
n  = 100;    % Число блужданий 
h  = 0.1;  % Шаг разбиения

xs = -1 : h : 1;  % Задали сетку
ys = -1 : h : 1;  %

F  = zeros(numel(xs), numel(ys));
for k = 1:n
    for i = 1:numel(xs)
        for j = 1:numel(ys)
            cur_i = i;
            cur_j = j;
            x = xs(cur_i);
            y = ys(cur_j);
            
            if ~is_inner_or_bound(x, y)
                F(i, j) = NaN;
                continue;
            end
        
            while(~is_bound(x, y, h))
                rnd = randsample(1:4, 1);
                if (rnd == 1)
                    cur_i = cur_i + 1;
                else
                    if (rnd == 2)
                        cur_i = cur_i -1;
                    else
                        if (rnd == 3)
                            cur_j = cur_j + 1;
                        else
                            cur_j = cur_j - 1;
                        end
                    end
                end
                x = xs(cur_i);
                y = ys(cur_j);
            end
            
            F(i, j) = x^2 + y^2;
        end
    end
end

F = F ./ n;

mesh(xs, ys, F);

function is = is_inner_or_bound(x, y)
    is = (x^2 + y^2 <= 1);
end
    
function is = is_bound(x, y, h)
    is = (x^2 + y^2 <= 1) & (     ...
              ((x+h)^2 + y^2 > 1) ...
            | ((x-h)^2 + y^2 > 1) ...
            | (x^2 + (y+h)^2 > 1) ...
            | (x^2 + (y-h)^2 > 1) ...
        );
end

function is = is_inner(x, y, h)
    is = (x^2 + y^2 <= 1) & ~is_bound(x, y, h);
end