%
% Монте-Карло на С++ хороший, а с квадратурой С++ не справляется: слишком
% большие числа, часто уходят в околобесконечность и интеграл идет туда же.
% Поэтому квадратуру лучше посмотреть отсюда.
%
%% Метод Монте--Карло

n = 1e5;

sn = 0;
sigma = 0;
alpha = 0.95;

tic;
for i = 1:n
    xs = normrnd(0, sqrt(0.5), 1, 10);
    fcn = pi^5 * exp(-1/(2^7*prod(xs).^2))/prod(xs).^2;
    sn = sn + fcn;
    sigma = sigma + fcn^2;
end
integral = sn/n;
toc;

disp(['Значение интеграла: ', num2str(integral)]);
x_p = norminv((1 + alpha)/2, 0, 1);
eps = x_p * sqrt(sigma/n - integral^2) / sqrt(n);
disp(['Погрешность:        ', num2str(eps)]);

clear
%% Метод квадратур
n = 6; 

fcn = @(x) pi^10 .*exp(-(sum(tan(pi/2.*x).^2)+ 1./128.*(prod(cot(pi/2.*x).^2))))./prod(sin(pi/2.*x).^2); 

tic 

x = zeros(1, 10); 

delta = (n-1)^(-10); 

x_k = linspace(0, 1, n) + 1/(2*(n-1));

integral = 0; 
for i = 1:n-1 
x(1) = x_k(i); 
    for i = 1:n-1 
    x(2) = x_k(i); 
        for i = 1:n-1 
        x(3) = x_k(i); 
            for i = 1:n-1 
            x(4) = x_k(i); 
                for i = 1:n-1 
                x(5) = x_k(i); 
                    for i = 1:n-1 
                    x(6) = x_k(i); 
                        for i = 1:n-1 
                        x(7) = x_k(i); 
                            for i = 1:n-1 
                            x(8) = x_k(i); 
                                for i = 1:n-1 
                                x(9) = x_k(i); 
                                    for k = 1:n-1 
                                        x(10) = x_k(k); 
                                        integral = fcn(x) + integral; 
                                    end 
                                end 
                            end 
                        end 
                    end 
                end 
            end 
        end 
    end 
end  
integral = integral * delta; 

toc
disp(['Значение интеграла: ', num2str(integral)]);
