% HW1 Problem 6b


clear;
clc;

analyticValue = 23*pi/192;
fprintf('Analytic probability: %.10f\n', analyticValue);
rng(4100);
maxN = 1e6;
sampleSizes = unique(round(logspace(1, log10(maxN), 80))).';

x = rand(maxN, 1);
y = rand(maxN, 1);
z = rand(maxN, 1);
success = (x.^2 + y.^2 < z) & (z.^2 > x.*y);
cumulativeSuccesses = cumsum(success);
estimates = cumulativeSuccesses(sampleSizes) ./ sampleSizes;

fprintf('Monte Carlo estimate at N = %d: %.10f\n', ...
	maxN, estimates(end));
fprintf('Absolute error at N = %d: %.10f\n', ...
	maxN, abs(estimates(end) - analyticValue));

figure;
semilogx(sampleSizes, estimates, 'o-', 'LineWidth', 1.1, ...
	'MarkerSize', 4, 'DisplayName', 'Monte Carlo estimate');
hold on;
semilogx(sampleSizes, analyticValue * ones(size(sampleSizes)), 'r--', ...
	'LineWidth', 1.5, 'DisplayName', 'Analytic value: 23\pi/192');
grid on;
xlabel('Sample size N');
ylabel('Estimated probability');
title('Monte Carlo estimate versus sample size');
legend('Location', 'best');
hold off;
