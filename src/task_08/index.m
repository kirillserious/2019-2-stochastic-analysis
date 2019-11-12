%% Рисуем сетку

n = 21;

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


%% 