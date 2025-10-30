# 🔊 FIR Filter Types — Magnitude, Phase & Zero–Pole Diagrams

A compact MATLAB exercise that **plots frequency magnitude, phase, and zero–pole diagrams** for **FIR Types I–IV** using simple example impulse responses.  
Great for quick visual intuition on what symmetry (symmetric vs antisymmetric) and length parity (even vs odd) do to FIR filter behavior.

![Preview](fig_fir_types.png)
---

## 📁 What this project includes
- 📈 **Magnitude responses** (`|H(e^{j\omega})|`) across normalized frequency.  
- 🌀 **Phase responses** using `unwrap(angle(H))` for clarity.  
- 🎯 **Zero–pole maps** via `zplane` to visualize roots on the unit circle.  
- 🧩 **Four canonical FIR types** with representative impulse responses:
  - **Type I** — even length, **symmetric** `h[n]`  
  - **Type II** — odd length, **symmetric** `h[n]`  
  - **Type III** — even length, **antisymmetric** `h[n]`  
  - **Type IV** — odd length, **antisymmetric** `h[n]`  

> The script is intentionally minimal so you can swap in your own `h` to see how responses change.

---

## 🧪 How to run (MATLAB)
1. Open MATLAB (or Octave with the Signal package).  
2. Paste the script below into a new file (e.g., `fir_types_demo.m`) and run it.

```matlab
% Eric Darko
% Filter Types for FIR - Magnitude, Phase, and Pole-Zero Diagrams

% Define the impulse responses for FIR filter types I-IV
h1 = [1 2 3 4 4 3 2 1];     % FIR Type I  (M even, symmetric)
h2 = [1 2 3 4 3 2 1];       % FIR Type II (M odd, symmetric)
h3 = [-1 -2 -3 -4 3 3 2 1]; % FIR Type III (M even, antisymmetric)
h4 = [-1 -2 -3 0 3 2 1];    % FIR Type IV (M odd, antisymmetric)

% Create a figure for the plots
figure;

% Define a cell array for the filters and their titles
filters = {h1, h2, h3, h4};
titles = {'FIR Type I', 'FIR Type II', 'FIR Type III', 'FIR Type IV'};

for i = 1:length(filters)
    h = filters{i};
    
    % Compute frequency response
    [H, w] = freqz(h, 1, 512);
    
    % Magnitude response
    subplot(4, 3, (i-1)*3 + 1);
    plot(w/pi, abs(H));
    title([titles{i} ' - Magnitude']);
    xlabel('Normalized Frequency (\times \pi rad/sample)');
    ylabel('Magnitude');
    grid on;

    % Phase response
    subplot(4, 3, (i-1)*3 + 2);
    plot(w/pi, unwrap(angle(H)));
    title([titles{i} ' - Phase']);
    xlabel('Normalized Frequency (\times \pi rad/sample)');
    ylabel('Phase (radians)');
    grid on;

    % Zero-Pole plot
    subplot(4, 3, (i-1)*3 + 3);
    zplane(h, 1);
    title([titles{i} ' - Zero-Pole']);
    grid on;
end

% Adjust layout
sgtitle('FIR Filter Types - Magnitude, Phase, and Zero-Pole Diagrams');
```

---

## 🧠 Quick theory bites (why the types matter)
- **Symmetry** controls whether the filter can achieve **linear phase** (symmetric ⇒ linear phase for Types I & II; antisymmetric ⇒ linear phase with a π/2 discontinuity for Types III & IV).  
- **Length parity** (even/odd) affects the **DC (ω=0)** and **Nyquist (ω=π)** responses and where zeros land on the unit circle.  
- **Zero distribution** on the **unit circle** determines **stopbands**; symmetric real FIRs have **conjugate‑reciprocal zero pairs**.

> Swap the example `h` vectors with your own designs (e.g., from `fir1`, `firpm`, or windowed sinc) to see real design behavior.

---

## 🧩 Tips & troubleshooting
- If you see phase wraps, `unwrap` is already enabled — ensure your `h` is real for classic linear‑phase behavior.  
- If `zplane` is missing in Octave, install the `signal` package: `pkg load signal`.  
- Use more FFT points in `freqz(h,1,N)` (e.g., `N=2048`) for smoother curves.

---

## 📜 License
MIT — feel free to use and adapt for coursework and demos.

---

## 🙌 Credits
Created by **Eric Darko** — educational visualization of FIR filter families.
