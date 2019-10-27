%% Метод Монте--Карло
n = 1e6;

sn = 0;
sigma = 0;
alpha = 0.95;

tic;
for i = 1:n
    xs = normrnd(0, sqrt(0.5), 1, 10);
    F = pi^5 * exp(-1/(2^7*prod(xs).^2))/prod(xs).^2;
    sn = sn + F;
    sigma = sigma + F^2;
end
integral = sn/n;
toc;

disp(['integral = ', num2str(integral)]);
x_p = norminv((1 + alpha)/2, 0, 1);
eps = x_p * sqrt(sigma/n - integral^2) / sqrt(n);
disp(['error = ', num2str(eps)]);

clear
%% Метод квадратур
F = @(x) pi^10 .*exp(-(sum(tan(pi/2.*x).^2)+ 1./128.*(prod(cot(pi/2.*x).^2))))./prod(sin(pi/2.*x).^2); 

tic 
N = 3; 
x = zeros(1,N); 
K = 7; 
delta = (K-1)^(-N); 
x_k = linspace(0,1,K) + 1/(2*(K-1)); 
x_k(K) = []; 
S = 0; 
for i = 1:K-1 
x(1) = x_k(i); 
    for i = 1:K-1 
    x(2) = x_k(i); 
        for i = 1:K-1 
        x(3) = x_k(i); 
            for i = 1:K-1 
            x(4) = x_k(i); 
                for i = 1:K-1 
                x(5) = x_k(i); 
                    for i = 1:K-1 
                    x(6) = x_k(i); 
                        for i = 1:K-1 
                        x(7) = x_k(i); 
                            for i = 1:K-1 
                            x(8) = x_k(i); 
                                for i = 1:K-1 
                                x(9) = x_k(i); 
                                    for k = 1:K-1 
                                        x(10) = x_k(k); 
                                        S = F(x) + S; 
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

toc 
integral = S*delta; 
disp(['integral = ', num2str(integral)]);
