# 🧮 MATLAB FFT and FFTSHIFT Project

This project demonstrates how to compute and visualize the **frequency domain representation** of a sinusoidal signal using MATLAB’s `fft` and `fftshift` functions.

---

## 📌 **Overview**

We generate a simple sinusoidal signal:

\[ x(t) = \sin(2\pi 50 t) \]

and use the **Fast Fourier Transform (FFT)** to analyze its **frequency spectrum**.  
Then we apply `fftshift` to center the spectrum around 0 Hz.

---

## 🧰 **MATLAB Concepts Used**
- 🌀 `fft(x)` – Fast Fourier Transform  
- 🔁 `fftshift(X)` – Shift zero-frequency component to the center  
- 🧭 Frequency axis calculation  
- 🪄 Time domain and frequency domain plotting

---

## 🧪 **Code Snippet**

```matlab
clc; clear; close all;

t = -1:0.001:1;
x = sin(2*pi*50*t);

figure;
subplot(2,1,1)
plot(t(1001:1200), x(1001:1200));
grid on;
title('Sin(2\pi50t)');
xlabel('Time, s');
ylabel('Amplitude');

X = abs(fft(x));
X2 = fftshift(X);
f = -499.9:1000/2001:500;

subplot(2,1,2)
plot(f, X2);
grid on;
title('Frequency domain representation of Sin(2\pi50t)');
xlabel('Frequency, Hz.');
ylabel('|X(f)|');
```

---

## 📊 **Result**

The time-domain plot shows the sinusoidal wave.  
The frequency-domain plot shows two sharp peaks at **+50 Hz** and **–50 Hz**, corresponding to the sinusoid’s frequency.

🟦 **Peak at 50 Hz**  
🟥 **Peak at -50 Hz**

---

## 🧭 **Applications**
- Signal processing 🧠  
- Communications systems 📡  
- Control systems ⚙️  
- Spectral analysis 📈

---

## 📎 **How to Run**
1. Open MATLAB 🧮
2. Copy the script into a `.m` file (e.g., `fft_sinusoid.m`).
3. Run the script.
4. View both the time-domain and frequency-domain plots.

---

## 📚 **References**
- MATLAB Documentation: [`fft`](https://www.mathworks.com/help/matlab/ref/fft.html) | [`fftshift`](https://www.mathworks.com/help/matlab/ref/fftshift.html)

---

## 📝 License
This project is released under the MIT License.

---

Made with ❤️ in MATLAB
