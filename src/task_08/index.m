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
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
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
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
zlabel('$f$', 'interpreter', 'latex');
clear

%% Численное решение
step = 0.02;
mic = 200;

f_fcn = @(x, y) x.^2 - y.^2;
mesh = -1:step:1;
n = numel(mesh);
xs = mesh;
ys = mesh;
U = zeros(n, n);
N = zeros(n, n);
[X, Y] = meshgrid(mesh);
pos = [n/2, 0];

mesh_n = sum(sum(X .^ 2 + Y .^ 2 >= 1));  % Внешние точки

if xs(round(n/2))^2 + ys(1)^2 >= 1
    pos = [round(n/2), 1];
end
is_border = 1;
f_value = f_fcn(xs(pos(1)), ys(pos(2)));

while sum(sum(N < mic)) > mesh_n
    pos = new_position(pos, n);
    if is_border
        while xs(pos(1))^2 + ys(pos(2))^2 >= 1
            pos = new_position(pos, n);
        end
    end
    if xs(pos(1))^2 + ys(pos(2))^2 < 1
        U(pos(2), pos(1)) = U(pos(2), pos(1)) + f_value;
        N(pos(2), pos(1)) = N(pos(2), pos(1)) + 1;
	is_border = 0;
    else
        f_value = f_fcn(xs(pos(1)), ys(pos(2)));
        is_border = 1;
    end
end

U = U ./ N;
figure, hold n, grid on;
surface(X, Y, U);
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
zlabel('$z$', 'interpreter', 'latex');

clear;

function result = new_position(position, n)
    result = position + round(rand(1, 2)) * 2 - 1;
    if result(1) < 1
        result(1) = 1;
    else
        if result(1) > n
            result(1) = n - 1;
        end
    end
    if result(2) < 1
        result(2) = 1;
    else
        if result(2) > n
            result(2) = n - 1;
        end
    end
end
