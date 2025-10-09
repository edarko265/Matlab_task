# 🧮 MATLAB DFT: Magnitude & Phase (Single-Argument `fft`)

This repo demonstrates how to compute and visualize the **Discrete Fourier Transform (DFT)** of a multi‑tone signal using MATLAB’s single‑argument `fft`. You’ll plot the **time signal**, **magnitude spectrum**, and **phase (unwrapped)** like in the assignment slide.

---

## 📌 Problem Summary

- Sampling frequency: **Fs = 100 Hz**
- Time vector: `t = 0:1/100:10-1/100`  (10 s, **N = 1000** samples)
- Signal:  
  \[ x(t) = \sin(2\pi\cdot 15\,t) + \sin(2\pi\cdot 40\,t) \]
- Compute DFT with `fft(x)` and plot:
  - **Magnitude**: `abs(y)`  
  - **Phase**: `unwrap(angle(y))` (after zeroing tiny magnitudes to reduce round‑off)
- Frequency axis: `f = (0:length(y)-1)*Fs/length(y)`
- Helpful ticks: `ax.XTick = [15 40 60 85]`

You should see magnitude spikes at **15, 40, 60 (= Fs−40), 85 (= Fs−15) Hz**.

---

## 🧪 MATLAB Script

```matlab
clc; clear; close all;

% Time vector and signal
Fs = 100;
t  = 0:1/Fs:10-1/Fs;                 % 0 … 9.99 s (N = 1000)
x  = sin(2*pi*15*t) + sin(2*pi*40*t);

% --- Plot original signal ---
figure;
subplot(3,1,1);
plot(t, x);
grid on;
title('Given Original Signal');
xlabel('Time, s'); ylabel('Amplitude');

% --- DFT (single-argument) ---
y = fft(x);
m = abs(y);

% Reduce round-off for phase
y(m < 1e-6) = 0;
p = unwrap(angle(y));                % radians

% Frequency vector
f = (0:length(y)-1) * Fs / length(y);

% --- Magnitude ---
subplot(3,1,2);
plot(f, m);
grid on; title('Magnitude');
xlabel('Frequency, Hz'); ylabel('|Y(f)|');
ax = gca; ax.XTick = [15 40 60 85];

% --- Phase (degrees) ---
subplot(3,1,3);
plot(f, p * 180/pi);
grid on; title('Phase');
xlabel('Frequency, Hz'); ylabel('Phase (deg)');
ax = gca; ax.XTick = [15 40 60 85];
```

---

## 🧠 Quick Theory

- **DFT (`fft`)** converts a finite-length, discrete-time signal to its frequency components.  
- **Magnitude** shows how strong each frequency is.  
- **Phase** shows the time shift of each sinusoidal component.  
- **`unwrap(angle(y))`** avoids phase jumps by adding or subtracting multiples of 2π.  
- Zeroing tiny magnitudes before `angle` helps prevent noisy/undefined phase values.

---

## ▶️ How to Run
1. Open MATLAB (desktop or online).  
2. Create a new script and paste the code above (e.g., `dft_magnitude_phase.m`).  
3. Run the script.  
4. Submit your **figure** and **code** to Moodle.

---

## 🧩 Tips
- If your peaks are misplaced, verify `Fs`, `N`, and the frequency vector formula.  
- For cleaner spectra, you may also plot **one-sided** magnitude using `0:N/2` and scale, but this exercise uses the full spectrum.

---

## 📜 License
MIT — free to use with attribution.

---

Made with ❤️ for DSP learners.  
