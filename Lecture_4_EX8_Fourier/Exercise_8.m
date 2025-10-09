clc; clear; close all;

% Time vector: Fs = 100 Hz, duration = 10 s  -> N = 1000 samples
t = 0:1/100:10-1/100;      % 0 … 9.99 s

% Given signal
x = sin(2*pi*15*t) + sin(2*pi*40*t);

% --- Plot original signal ---
figure;
subplot(3,1,1);
plot(t, x);
grid on;
title('Given Original Signal');
xlabel('Time, s'); ylabel('Amplitude');

% --- DFT (single-argument fft), magnitude and phase ---
y = fft(x);                % DFT
m = abs(y);                % Magnitude

% Reduce round-off when computing phase:
y(m < 1e-6) = 0;           % zero-out tiny-magnitude bins before phase
p = unwrap(angle(y));      % Phase (radians)

% Frequency vector for Fs = 100 Hz
f = (0:length(y)-1) * 100 / length(y);

% --- Magnitude plot ---
subplot(3,1,2);
plot(f, m);
grid on;
title('Magnitude');
xlabel('Frequency, Hz'); ylabel('|Y(f)|');
ax = gca;
ax.XTick = [15 40 60 85];

% --- Phase plot (in degrees) ---
subplot(3,1,3);
plot(f, p * 180/pi);
grid on;
title('Phase');
xlabel('Frequency, Hz'); ylabel('Phase (deg)');
ax = gca;
ax.XTick = [15 40 60 85];
