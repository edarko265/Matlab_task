
%% week3_Z_transform.m
% Single script covering Tasks A1–A5 with figures saved for README
% Author: <Your Name>
% Course: DSP - Z-Transform Practice
% Run section-by-section (or all at once). Figures are saved as PNGs in the working folder.

clear; close all; clc;

fprintf('=== WEEK 3: Z-TRANSFORM TASKS ===\n');

%% A1 – Warm-up: Finite Sequences → Polynomials
% For finite-length sequences, X(z) = sum_{n=0}^{N-1} x[n] z^{-n} (a finite polynomial)
try
    syms z
    fprintf('\nA1 – Finite sequences as polynomials in z^{-1}:\n');
    
    % (i) x[n] = {1, 2, 5} at n = {0,1,2}
    X1 = 1 + 2*z^(-1) + 5*z^(-2);
    disp('A1(i)  X1(z) ='); pretty(X1)
    
    % (ii) x[n] = {0, 3, 0, 4} at n = {0,1,2,3}
    X2 = 0 + 3*z^(-1) + 0*z^(-2) + 4*z^(-3);
    disp('A1(ii) X2(z) ='); pretty(X2)
    
    % Note: Finite sequences => polynomial in z^{-1}; ROC is entire z-plane
catch ME
    warning('A1: Symbolic Math Toolbox may be missing. Error: %s', ME.message);
end

%% A2 – Infinite Sequences & ROC
% Right-sided: ROC is outside outermost pole (|z| > |a| for a^n u[n])
% Left-sided:  ROC is inside innermost pole (|z| < |a| for a^n u[-n-1])
try
    syms n z a
    assume(abs(a) < 1)
    fprintf('\nA2 – Infinite sequences and ROC:\n');
    
    % (a) x[n] = a^n u[n], with a = 0.6
    a_val = 0.6;
    X_a = ztrans( (a_val)^n * heaviside(n), n, z );
    disp('A2(a): X(z) for a = 0.6 =>'); pretty(X_a)
    disp('ROC: |z| > 0.6');
    
    % (b) x[n] = (-0.8)^n u[n]
    b_val = -0.8;
    X_b = ztrans( (b_val)^n * heaviside(n), n, z );
    disp('A2(b): X(z) for a = -0.8 =>'); pretty(X_b)
    disp('ROC: |z| > 0.8');
    
    % (c) x[n] = -(0.9)^n u[-n-1]   (left-sided)
    c_val = 0.9;
    X_c = ztrans( -(c_val)^n * heaviside(-n-1), n, z );
    disp('A2(c): X(z) for left-sided sequence =>'); pretty(X_c)
    disp('ROC: |z| < 0.9');
catch ME
    warning('A2: Symbolic Math Toolbox may be missing. Error: %s', ME.message);
end

%% A3 – Properties: Linearity & Shifting
% x1[n] = (0.5)^n u[n],  x2[n] = (-0.5)^n u[n]
% (a) Z{2x1[n] − 3x2[n]} = 2X1 - 3X2
% (b) Time shift: Z{x1[n-3]} = z^{-3} X1(z)
try
    syms n z
    fprintf('\nA3 – Properties (Linearity & Shifting):\n');
    
    x1 = (0.5)^n * heaviside(n);
    x2 = (-0.5)^n * heaviside(n);
    
    % (a) Linearity
    X_lin = ztrans( 2*x1 - 3*x2, n, z );
    disp('A3(a): Z{2x1 - 3x2} ='); pretty(X_lin)
    
    % (b) Time-shift: x1[n-3]
    x1_shift = subs(x1, n, n-3);
    X_shift = ztrans( x1_shift, n, z );
    disp('A3(b): Z{x1[n-3]} ='); pretty(X_shift)
catch ME
    warning('A3: Symbolic Math Toolbox may be missing. Error: %s', ME.message);
end

%% A4 – Inverse Z-Transform
% (a) X(z) = 1 / (1 − 0.7 z^{−1}) => x[n] = (0.7)^n u[n] (causal, |z|>0.7)
% (b) X(z) = (1 − 0.5 z^{−1}) / (1 − 0.8 z^{−1})
try
    syms n z
    fprintf('\nA4 – Inverse Z-transform:\n');
    
    Xa = 1 / (1 - 0.7*z^(-1));
    xa = iztrans(Xa, z, n);
    disp('A4(a): x[n] ='); pretty(xa)
    
    Xb = (1 - 0.5*z^(-1)) / (1 - 0.8*z^(-1));
    xb = iztrans(Xb, z, n);
    disp('A4(b): x[n] ='); pretty(xb)
catch ME
    warning('A4: Symbolic Math Toolbox may be missing. Error: %s', ME.message);
end

%% A5 – H(z), Poles/Zeros & Frequency Response
% H(z) = (1 − 2.4 z^{−1} + 2.88 z^{−2}) / (1 − 0.8 z^{−1} + 0.64 z^{−2})
fprintf('\nA5 – Poles/Zeros & Frequency Response:\n');

b = [1 -2.4 2.88];
a = [1 -0.8 0.64];

% (a) Numeric poles and zeros
z_z = roots(b);
p_z = roots(a);
k_gain = b(1)/a(1); %#ok<NASGU> % overall gain if needed

disp('Zeros:');
disp(z_z.');
disp('Poles:');
disp(p_z.');

% Plot pole-zero (requires Signal Processing Toolbox)
try
    h1 = figure('Name','Pole-Zero Plot','NumberTitle','off');
    zplane(b,a); grid on; title('Pole-Zero Plot H(z)');
    saveas(h1, 'fig_A5_pz.png');
catch ME
    warning('zplane may require Signal Processing Toolbox. Error: %s', ME.message);
end

% (b) Magnitude and phase responses
try
    [H,w] = freqz(b,a,512,'whole');  % 0..2pi
    % Keep 0..pi for standard plots
    w = w(1:257); H = H(1:257);
    
    h2 = figure('Name','Frequency Response','NumberTitle','off');
    subplot(2,1,1); plot(w/pi, abs(H)); grid on; ylabel('|H|'); title('Magnitude Response');
    subplot(2,1,2); plot(w/pi, angle(H)); grid on; xlabel('\omega/\pi'); ylabel('Phase (rad)');
    saveas(h2, 'fig_A5_freq.png');
catch ME
    warning('freqz may require Signal Processing Toolbox. Error: %s', ME.message);
end

% Optional test signal
try
    n = 0:511;
    x = sin(0.2*pi*n) + 0.5*sin(0.8*pi*n);
    y = filter(b,a,x);
    
    h3 = figure('Name','Signal Test','NumberTitle','off');
    subplot(2,1,1); plot(n, x); grid on; title('Input x[n]'); xlabel('n');
    subplot(2,1,2); plot(n, y); grid on; title('Output y[n] = filter(b,a,x)'); xlabel('n');
    saveas(h3, 'fig_A5_signal.png');
catch ME
    warning('filter/plot section skipped: %s', ME.message);
end

fprintf('\nDone. Figures saved as fig_A5_pz.png, fig_A5_freq.png, fig_A5_signal.png (if generated).\n');
