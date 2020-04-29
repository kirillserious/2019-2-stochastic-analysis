%% Задача 1
max_i  = 100;
lambda = 0.05;

ts = exp_generate(lambda, 1, max_i);
ts = cumsum(ts);
ss = chi2rnd(10, 1, max_i);

qs = zeros(1, max_i);
ns = zeros(1, max_i);

qs(1) = ts(1) + ss(1);
ns(1) = 0;
for i = 2 : max_i
    ns(i) = sum(qs > ts(i));
    qs(i) = ts(i) + max(0, qs(i-1) - ts(i)) + ss(i);
end

figure, hold on, grid on;
stairs(ts, ns);
xlabel('$t_i$', 'interpreter', 'latex');
ylabel('$n_i$', 'interpreter', 'latex');

%% Задача 2
lambda0 = 10;
n = 1000;
time = zeros(1, n);

times = 0;
k = 0;
result = zeros(1, n);
while k <= n - 1
    xi = exprnd(1/(2*lambda0), 1);
    times = times + xi;    
    if bern_generate((1 + cos(times))/2)
        k = k + 1;
        result(k) = k;
        time(k) = times;
    end    
end

figure, hold on, grid on;

plot(time, lambda0.*(1 + cos(time)));
plot(time, result);

legend('$\lambda(t)$', '$W_t$', 'interpreter', 'latex');
xlabel('$t$', 'interpreter', 'latex');

%% Задача 3
n = 1000;
lambda  = 0.1;
xm = 1;
k = 2;
W0 = 300;
c = 0.25;

times = exp_generate(lambda, 1, n);
times = cumsum(times);

ss = pareto_generate(xm, k, 1, n);
ss = cumsum(ss);

ws = W0.*ones(1, numel(times)) + c.*times - ss;    
ind = find(ws < 0);  
if ~isempty(ind)
    ws (ind(1):end)= 0;
end

figure, hold on, grid on;
plot(times, ws);
xlim([0 times(end)]);
xlabel('$t_i$', 'interpreter', 'latex');
ylabel('$W$', 'interpreter', 'latex');