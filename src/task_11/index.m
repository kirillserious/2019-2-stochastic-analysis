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