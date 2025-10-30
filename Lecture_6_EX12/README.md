# 🔊 FIR Low‑Pass Filter (LPF) with `sinc` — MATLAB Exercise

Design and visualize **FIR Low‑Pass Filters** using the **truncated sinc** (ideal LPF) approach.  
This exercise compares different **filter orders (M)** and shows how length affects the **impulse** and **magnitude** responses.

---

## 📦 What’s included
- 📄 MATLAB script that:
  - Generates the **ideal LPF impulse response** via `sinc` truncation
  - Computes the **FFT-based frequency response**
  - Saves plots for:
    - **Impulse response** `h_{LP}(n)`
    - **Magnitude response** `|H_{LP}(e^{j\omega})|`
    - **Comparison** of magnitude responses across `M`
- 🖼️ Plots saved under: `figures/`
  - `hLP_M20.png`, `HLP_M20.png`
  - `hLP_M64.png`, `HLP_M64.png`
  - `HLP_compare.png`

> The figures folder is created automatically by the script (relative to the script path).

---

## 🧠 Quick theory
For an **ideal** discrete‑time LPF with cutoff \( \omega_c \) (rad/sample), the impulse response is

\[
h_{\text{ideal}}[n] = \frac{\sin\big(\omega_c (n - M/2)\big)}{\pi (n - M/2)},\quad
h_{\text{ideal}}[M/2] = \frac{\omega_c}{\pi}.
\]

We **truncate** this to a finite length of \( M+1 \) taps (indices \( n = 0 \ldots M \)).  
Larger \( M \) → **narrower transition band** and **lower sidelobes** (with simple truncation).

> Tip: To reduce Gibbs ripples, apply a **window** (e.g., Hamming) to `h_{LP}`.

---

## ⚙️ Parameters (editable)
- `M_values = [20, 64]` → filter orders to compare  
- `wc = 1` → cutoff (rad/sample)  
- `N_fft = 1024` → FFT length for plotting

---

## ▶️ How to run
1. Open MATLAB.
2. Paste your script into a file (e.g., `fir_lpf_sinc_demo.m`) and run.
3. Outputs will be saved in a `figures/` folder alongside the script.

---

## 🧪 What the script does
- Builds `h_LP` with:
  ```matlab
  h_LP = sin(wc * (n - M/2)) ./ (pi * (n - M/2));
  h_LP(n == M/2) = wc / pi;  % removable singularity at center
  ```
- Computes frequency response:
  ```matlab
  H_LP = fft(h_LP, N_fft);
  w = linspace(-pi, pi, N_fft);
  plot(w/pi, abs(fftshift(H_LP)));
  ```
- Saves figures:
  - `figures/hLP_M{M}.png`
  - `figures/HLP_M{M}.png`
  - `figures/HLP_compare.png`

---

## 🧩 Customization ideas
- Apply a **window**: `h_LP = h_LP .* hamming(M+1).';`
- Change cutoff `wc` and re‑run.
- Increase `N_fft` (e.g., 4096) for smoother curves.
- Normalize passband gain if desired.

---

## 📁 Expected outputs (once you run the script)
- **Impulse responses**
  - `figures/hLP_M20.png`
  - `figures/hLP_M64.png`
- **Magnitude responses**
  - `figures/HLP_M20.png`
  - `figures/HLP_M64.png`
- **Comparison plot**
  - `figures/HLP_compare.png`

---

## 📜 License
MIT — free to use in coursework and demos.

---

## 🙌 Credits
Exercise prepared by **Eric Darko**.  
This README generated for quick GitHub documentation.
