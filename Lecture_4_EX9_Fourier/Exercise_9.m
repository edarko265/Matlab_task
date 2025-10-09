clc; clear; close all;

% --- Parameters ---
Fs = 100;                           % sampling frequency (Hz)
t  = 0:1/Fs:10-1/Fs;                % 0 … 9.99 s (N = 1000 samples)

% --- Original signal (same as Exercise 8) ---
x = sin(2*pi*15*t) + sin(2*pi*40*t);

% --- N-point DFT (use second argument of fft) ---
n = 512;                            % DFT length as required
y = fft(x, n);                      % N-point DFT
m = abs(y);                         % Magnitude

% Reduce round-off error for phase by zeroing tiny magnitudes
y(m < 1e-6) = 0;
p = unwrap(angle(y));               % Phase (radians)

% --- Frequency vector for N-point DFT ---
f = (0:n-1) * Fs / n;               % 0 … Fs-Δf

% --- Plots (Magnitude & Phase) ---
figure;

subplot(2,1,1);
plot(f, m);
grid on;
title('Magnitude');
xlabel('Frequency, Hz'); ylabel('|Y(f)|');
xlim([0 Fs]);                       % show 0..100 Hz like the slide
ax = gca; ax.XTick = [15 40 60 85];

subplot(2,1,2);
plot(f, p * 180/pi);
grid on;
title('Phase');
xlabel('Frequency, Hz'); ylabel('Phase (deg)');
xlim([0 Fs]);
ax = gca; ax.XTick = [15 40 60 85];
