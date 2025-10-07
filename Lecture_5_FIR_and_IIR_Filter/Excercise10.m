clear; clc;

b1 = ones(1,5);   a1 = 1;
b2 = ones(1,9);   a2 = 1;

% Frequency responses
nfft = 2048;
[H1,w1] = freqz(b1,a1,nfft);
[H2,w2] = freqz(b2,a2,nfft);

% ZPK via roots (safe for FIR with a=1)
z1 = roots(b1);   p1 = roots(a1);   k1 = b1(1)/a1(1);
z2 = roots(b2);   p2 = roots(a2);   k2 = b2(1)/a2(1);

% Plots
figure('Color','w');
subplot(2,2,1); plot(w1/pi,abs(H1),'LineWidth',1.5); grid on;
xlabel('Normalized Freq (\times\pi)'); ylabel('|H_1|');
title('Transfer Function of 5 point MAF');

subplot(2,2,2); zplane(b1,a1); axis equal; title('Pole-zero: 5 point MAF');

subplot(2,2,3); plot(w2/pi,abs(H2),'LineWidth',1.5); grid on;
xlabel('Normalized Freq (\times\pi)'); ylabel('|H_2|');
title('Transfer Function of 9 point MAF');

subplot(2,2,4); zplane(b2,a2); axis equal; title('Pole-zero: 9 point MAF');

% (Optional) print zeros
disp('5-point zeros:'); disp(z1.');
disp('9-point zeros:'); disp(z2.');
