# 🧮 MATLAB DFT with N-Point FFT (Exercise 9)

This project demonstrates how to compute the **Discrete Fourier Transform (DFT)** of a signal using the **second argument of `fft`** in MATLAB.  
This is an extension of Exercise 8 — now with an **N-point FFT** (`n = 512`), which affects the frequency resolution.

---

## 📌 Problem Summary

- **Sampling frequency**: `Fs = 100 Hz`  
- **Time vector**: `t = 0:1/Fs:10-1/Fs` (10 seconds, 1000 samples)  
- **Signal**:  
  \[ x(t) = \sin(2\pi 15 t) + \sin(2\pi 40 t) \]
- **FFT length**: `n = 512`
- **FFT computation**: `y = fft(x, n)`

🧭 Peaks appear at **15 Hz**, **40 Hz**, **60 Hz (=Fs−40)**, and **85 Hz (=Fs−15)**.

---

## 🧪 MATLAB Code

```matlab
clc; clear; close all;

% --- Parameters ---
Fs = 100;                            % Sampling frequency (Hz)
t  = 0:1/Fs:10-1/Fs;                 % 0 … 9.99 s (N = 1000 samples)

% --- Original signal ---
x = sin(2*pi*15*t) + sin(2*pi*40*t);

% --- N-point DFT (second argument of fft) ---
n = 512;
y = fft(x, n);
m = abs(y);

% Reduce round-off error before phase
y(m < 1e-6) = 0;
p = unwrap(angle(y));               % Phase (radians)

% --- Frequency vector ---
f = (0:n-1) * Fs / n;

% --- Magnitude Plot ---
figure;
subplot(2,1,1);
plot(f, m);
grid on;
title('Magnitude');
xlabel('Frequency, Hz'); ylabel('|Y(f)|');
xlim([0 Fs]);
ax = gca; ax.XTick = [15 40 60 85];

% --- Phase Plot ---
subplot(2,1,2);
plot(f, p * 180/pi);
grid on;
title('Phase');
xlabel('Frequency, Hz'); ylabel('Phase (deg)');
xlim([0 Fs]);
ax = gca; ax.XTick = [15 40 60 85];
```

---

## 🧠 Key Concepts
- 🌀 `fft(x,n)`: computes an N-point DFT of the signal `x`, zero-padding or truncating as needed.
- 🔁 `unwrap(angle(y))`: unrolls the phase to avoid jumps at ±π.  
- 🪄 Smaller **n** → coarser resolution; larger **n** → finer frequency resolution.
- ⚡ Magnitude peaks appear symmetrically for real signals.

---

## ▶️ How to Run
1. Open MATLAB (desktop or online).
2. Create a new script named `exercise9_fft512.m`.
3. Paste the code above.
4. Run the script.
5. View both the **magnitude** and **phase** plots.

---

## 🧭 Results
- Magnitude spikes at **15 Hz**, **40 Hz**, **60 Hz**, and **85 Hz**.  
- Phase shows continuous transitions after `unwrap`.

---

## 📜 License
MIT — free to use and modify with attribution.

---

Made with ❤️ for DSP learners.
