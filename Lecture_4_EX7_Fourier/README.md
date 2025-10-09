# 🧮 MATLAB FFT & FFTSHIFT — Sinusoid → Spectrum

This repo shows how to compute and visualize the **frequency-domain** of sinusoidal signals in MATLAB using `fft` and `fftshift`.

- 📈 Time‑domain plots
- 📶 Frequency spectra (centered at 0 Hz)
- 🧑‍🏫 Clear, minimal scripts ready for **online MATLAB** or desktop MATLAB

---

## ✨ What you’ll learn
- 🌀 How `fft` reveals the spectrum of a discrete signal  
- 🔁 Why `fftshift` is used to center DC at **0 Hz**  
- 🧭 How to build a correct **frequency axis**

---

## 📂 Files
- `exercise6_single_tone.m` – Sinusoid: `sin(2π·50·t)`  
- `exercise7_two_tone.m` – Two tones: `sin(2π·50·t) + sin(2π·75·t)`  

Both use:
- Sampling step **Ts = 0.001 s → Fs = 1000 Hz**
- `N = 2001` samples on `t = -1:0.001:1`
- Frequency axis: `f = -499.9:1000/2001:500`

---

## ▶️ Quick Start
1. Open MATLAB (desktop or online).  
2. Copy a script into a new file with the matching name.  
3. Run it. You’ll see:
   - Top: time‑domain slice around t≈0  
   - Bottom: magnitude spectrum with peaks at the component frequencies

---

## 🧪 Code — Single Tone (50 Hz)
```matlab
clc; clear; close all;

t = -1:0.001:1;                 % Fs = 1000 Hz, N = 2001
x = sin(2*pi*50*t);

figure;
subplot(2,1,1);
plot(t(1001:1200), x(1001:1200));  % neat 0.2 s window
grid on; title('Sin(2\pi50t)'); xlabel('Time, s'); ylabel('Amplitude');

X  = abs(fft(x));
X2 = fftshift(X);
f  = -499.9:1000/2001:500;

subplot(2,1,2);
plot(f, X2);
grid on; title('Frequency domain of Sin(2\pi50t)');
xlabel('Frequency, Hz.'); ylabel('|X(f)|');
```

**Expected:** Peaks at **±50 Hz**.

---

## 🧪 Code — Two Tones (50 Hz + 75 Hz)
```matlab
clc; clear; close all;

t = -1:0.001:1;                     % Fs = 1000 Hz, N = 2001
x = sin(2*pi*50*t) + sin(2*pi*75*t);

subplot(2,1,1);
plot(t(1001:1200), x(1:200));       % matches the slide’s indices
grid on; title('Sin(2\pi50t)+Sin(2\pi75t)');
xlabel('Time, s'); ylabel('Amplitude');

X  = abs(fft(x));
X2 = fftshift(X);
f  = -499.9:1000/2001:500;

subplot(2,1,2);
plot(f, X2);
grid on; title('Frequency domain of Sin(2\pi50t) + Sin(2\pi75t)');
xlabel('Frequency, Hz.'); ylabel('|X(f)|');
```

**Expected:** Peaks at **±50 Hz** and **±75 Hz**.

---

## 🧠 Theory in 30 Seconds
- **FFT (`fft`)** converts a finite, sampled time signal into its discrete spectrum.  
- **`abs(fft(x))`** gives the magnitude spectrum; for real signals it’s symmetric.  
- **`fftshift`** reorders bins so frequency 0 is centered, showing negative to the left and positive to the right.  
- **Frequency axis** for `Fs=1000` and `N=2001`: from about **−500 Hz to +500 Hz**.

---

## 🛠️ Troubleshooting
- Flat spectrum? ✅ Ensure your `x` isn’t all zeros and indices match `t`.  
- Wrong peaks? ✅ Check `Fs`, `N`, and the frequency‑axis formula.  
- Clipping in plots? ✅ Use `grid on;` and verify you’re plotting `X2` vs `f`.

---

## 📜 License
MIT — use freely with attribution.

---

Made with ❤️ for DSP learners.
