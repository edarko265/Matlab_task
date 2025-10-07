# 📊 DSP Lab – Moving‑Average FIR Filters (5‑point & 9‑point)

<p align="center">
  <img alt="MATLAB" src="https://img.shields.io/badge/MATLAB-R202x-0076A8?logo=mathworks&logoColor=white">
  <img alt="Signal Processing" src="https://img.shields.io/badge/Signal%20Processing-FIR%20%26%20IIR-4caf50">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-blue">
</p>

> 🎯 **Goal**: Compute and visualize the frequency response and pole‑zero maps for **5‑point** and **9‑point** **moving‑average FIR** filters in MATLAB. Also, understand the differences between **FIR** and **IIR** filters.

---

## 🧪 What’s in this repo?

- 🧮 MATLAB script that:
  - uses `freqz` to compute frequency responses `H(e^{j\omega})`
  - converts transfer function to zeros/poles/gain (ZPK) for FIR via `roots` (or `tf2zpk` if available)
  - plots:
    - 📈 Magnitude response for **5‑pt** and **9‑pt** MAF
    - 🔘 Pole‑zero diagrams for **5‑pt** and **9‑pt** MAF
- 🧠 Clear notes on **FIR vs IIR** filters
- 🗒️ This README with quick instructions and references

---

## 📂 Files

```
/matlab
  └── maf_demo.m    % main script (5‑point & 9‑point MAF)
README.md           % this document
```

> 💡 If your MATLAB shows **“Transfer function not proper”** for `tf2zp`, use `roots` or `tf2zpk` (Signal Processing Toolbox) as shown below.

---

## ▶️ How to run

1. Open MATLAB.
2. Place `maf_demo.m` in your working folder.
3. Run:
   ```matlab
   maf_demo
   ```
4. You’ll see four figures:
   - **5‑pt** magnitude response
   - **5‑pt** pole‑zero plot
   - **9‑pt** magnitude response
   - **9‑pt** pole‑zero plot

---

## 🧷 MATLAB core snippet

```matlab
% Coefficients (un-normalized MAF)
b1 = ones(1,5); a1 = 1;
b2 = ones(1,9); a2 = 1;

% Frequency response
[H1,w1] = freqz(b1,a1,2048);
[H2,w2] = freqz(b2,a2,2048);

% Zeros/Poles/Gain for FIR
z1 = roots(b1); p1 = roots(a1); k1 = b1(1)/a1(1);
z2 = roots(b2); p2 = roots(a2); k2 = b2(1)/a2(1);

% Plots
figure; subplot(2,2,1), plot(w1/pi,abs(H1)); grid on; title('5‑pt MAF |H|');
subplot(2,2,2), zplane(b1,a1); axis equal; title('5‑pt MAF PZ');
subplot(2,2,3), plot(w2/pi,abs(H2)); grid on; title('9‑pt MAF |H|');
subplot(2,2,4), zplane(b2,a2); axis equal; title('9‑pt MAF PZ');
```

> ✅ For **unity DC gain**, normalize: `b1 = ones(1,5)/5;  b2 = ones(1,9)/9;`

---

## 📈 Expected results (intuition)

- The **moving‑average** is a **low‑pass** FIR filter.
- Increasing the window length (from **5** to **9**) gives:
  - a **narrower main lobe** (sharper low‑pass)
  - **more closely spaced zeros** on the unit circle → **deeper nulls** in the stopband
- Pole‑zero map:
  - **FIR MAF** has **all zeros** equally spaced on the unit circle (except \(z=1\) after normalization) and **poles at the origin** (or none if `a=1`), guaranteeing **stability**.

---

## 🧠 FIR vs IIR – quick guide

### 🔷 FIR (Finite Impulse Response)
- **Definition**: Output depends on a **finite** number of past inputs.
- **Form**: \( H(z) = \sum_{k=0}^{M} b_k z^{-k} \) (denominator often 1).
- **Pros**:
  - Always **BIBO‑stable** if coefficients are finite (no feedback poles).
  - Can be designed with **exact linear phase** (symmetric/antisymmetric taps) → minimal phase distortion.
  - **Simple** fixed‑point implementations; no risk of recursive instability.
- **Cons**:
  - For sharp transitions, may need **higher order** (more taps) → higher computation and latency.

### 🔶 IIR (Infinite Impulse Response)
- **Definition**: Output depends on past inputs **and** past outputs (feedback).
- **Form**: \( H(z) = \frac{\sum_{k=0}^{M} b_k z^{-k}}{1 + \sum_{r=1}^{N} a_r z^{-r}} \)
- **Pros**:
  - Achieves **sharp responses** (e.g., Butterworth, Chebyshev, Elliptic) with **lower order** → efficient.
- **Cons**:
  - **Stability** must be ensured (poles must lie **inside** the unit circle).
  - **Phase is nonlinear** (unless using all‑pass or special structures).
  - Can be **sensitive** to coefficient quantization in fixed‑point hardware.

> 🧭 **Rule of thumb**: Use **FIR** when you need **linear phase** and guaranteed stability; use **IIR** when you need **steep roll‑off** with minimal computation and you can manage stability/phase trade‑offs.

---

## 📚 Notes & tips

- `freqz(b,a,N)` returns complex response on \( \omega \in [0,\pi] \). Plot `abs(H)` for magnitude.
- `zplane(b,a)` is great for visualizing **zeros** (○) and **poles** (×). For FIR with `a=1`, you’ll see **only zeros** on/inside the unit circle.
- Moving‑average (length \(L\)) transfer function:
  \[
  H(z) = \frac{1}{L}\sum_{n=0}^{L-1} z^{-n} = \frac{1 - z^{-L}}{L(1 - z^{-1})}
  \]
  Zeros at the **L‑th roots of unity** (except \(z=1\)).
- If you see “**Transfer function not proper**” with `tf2zp`, switch to:
  ```matlab
  [z,p,k] = tf2zpk(b,a);  % Signal Processing Toolbox
  % or
  z = roots(b); p = roots(a); k = b(1)/a(1);
  ```

---

## 🧾 License

This project is released under the **MIT License**. See `LICENSE` for details.

---

## 🙌 Acknowledgements

- MATLAB® Signal Processing functions: `freqz`, `zplane`, `tf2zpk`
- Classic FIR/IIR references from Oppenheim & Schafer

---

### 🌟 Enjoy exploring filters! If this helped, consider ⭐ starring the repo.
