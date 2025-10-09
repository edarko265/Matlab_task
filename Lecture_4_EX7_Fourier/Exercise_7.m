clc; clear; close all;

% Define the value of t
t = -1:0.001:1;            % Ts = 0.001 s  -> Fs = 1000 Hz, N = 2001

% Write the given expression x in terms of t
x = sin(2*pi*50*t) + sin(2*pi*75*t);

subplot(2,1,1);
plot(t(1001:1200), x(1:200));   % (kept as in the slide prompt)
grid on;
title('Sin(2\pi50t)+Sin(2\pi75t)');
xlabel('Time, s'); ylabel('Amplitude');

subplot(2,1,2);
% X would be the fft of x
X = abs(fft(x));

% X2 would be shifted function of X
X2 = fftshift(X);

% assign f from -499.9 to 500 with increment of 1000/2001
f = -499.9:1000/2001:500;

plot(f, X2);
grid on;
title('Frequency domain representation of Sin(2\pi50t)+ Sin(2\pi75t)');
xlabel('Frequency, Hz.'); ylabel('|X(f)|');
