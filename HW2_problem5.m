%% Part (c): Vectorized simulation of the core-growth process (mu = 1)
R    = 1e3;      % number of independent realizations
Nmax = 1e4;      % final network size

C = ones(1,R);           % C(3) = 1 for every realization

for N = 3:(Nmax-1)
    p   = C ./ N;                 % mu = 1, so success prob = C(N)/N
    inc = rand(1,R) < p;          % one length-R Bernoulli draw per step
    C   = C + inc;                % update all realizations at once
end

z = C ./ Nmax;                    % final core fraction, one per realization

% Empirical statistics
mz   = mean(z);
sz   = std(z);
ratio = sz/mz;

fprintf('Empirical mean(z)      = %.4f  (theory 1/3 = %.4f)\n', mz, 1/3);
fprintf('Empirical std/mean     = %.4f  (theory sqrt(2) = %.4f)\n', ratio, sqrt(2));
fprintf('Smallest core seen: C = %d\n', min(C));
fprintf('Largest  core seen: C = %d\n', max(C));

% Plot normalized histogram vs theoretical density
figure;
histogram(z, 'Normalization','pdf', 'NumBins', 50, ...
    'FaceColor',[0.3 0.6 0.9], 'EdgeColor','none');
hold on;
zz = linspace(0,1,200);
plot(zz, 2*(1-zz), 'r-', 'LineWidth', 2);
xlabel('z = C/N'); ylabel('density');
legend('empirical (N=10^4, R=10^3)', 'h(z) = 2(1-z)');
title('Core fraction distribution at \mu = 1');
hold off;