% Eric Darko
% % FIR Low-Pass Filter Design using sinc function



clear; clc; close all;

% Parameters
M_values = [20, 64];    % Filter orders
wc = 1;                 % Cutoff frequency in radians/sample
N_fft = 1024;           % FFT length for frequency response

% Storage for results
n_values = cell(1, length(M_values));
h_LP_values = cell(1, length(M_values));
H_LP_values = cell(1, length(M_values));

% Ensure current working directory is writable
scriptDir = fileparts(mfilename('fullpath'));
figDir = fullfile(scriptDir, 'figures');

% Create figures directory if it doesn't exist
if ~exist(figDir, 'dir')
    mkdir(figDir);
end

% Loop over filter orders
for idx = 1:length(M_values)
    M = M_values(idx);
    n = 0:M; % Sample index
    n_values{idx} = n;

    % Compute ideal LPF impulse response (sinc-based)
    h_LP = sin(wc * (n - M/2)) ./ (pi * (n - M/2));
    h_LP(n == M/2) = wc / pi; % Handle divide-by-zero at center
    h_LP_values{idx} = h_LP;

    % Compute frequency response
    H_LP = fft(h_LP, N_fft);
    H_LP_values{idx} = H_LP;

    % -----------------------------
    % Plot impulse response
    % -----------------------------
    figure;
    stem(n, h_LP, 'filled');
    grid on;
    title(sprintf('Impulse Response h_{LP}(n), M = %d', M));
    xlabel('n');
    ylabel('h_{LP}(n)');
    saveas(gcf, fullfile(figDir, sprintf('hLP_M%d.png', M)));

    % -----------------------------
    % Plot magnitude response
    % -----------------------------
    w = linspace(-pi, pi, N_fft);
    figure;
    plot(w/pi, abs(fftshift(H_LP)), 'LineWidth', 1.2);
    grid on;
    title(sprintf('Magnitude Response |H_{LP}(e^{jω})|, M = %d', M));
    xlabel('ω/π');
    ylabel('|H_{LP}|');
    saveas(gcf, fullfile(figDir, sprintf('HLP_M%d.png', M)));
end

% -----------------------------
% Compare magnitude responses
% -----------------------------
figure;
hold on;
w = linspace(-pi, pi, N_fft);
for idx = 1:length(M_values)
    plot(w/pi, abs(fftshift(H_LP_values{idx})), 'LineWidth', 1.2, ...
        'DisplayName', sprintf('M = %d', M_values(idx)));
end
grid on;
title('Comparison of Magnitude Responses for Different Filter Orders');
xlabel('ω/π');
ylabel('|H_{LP}|');
legend show;
saveas(gcf, fullfile(figDir, 'HLP_compare.png'));

disp('All plots generated and saved.');