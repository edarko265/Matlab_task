
# 📚 Week 3 — Z-Transform Lab (MATLAB)

**Repository name**: `week3-Z-transform`  
**Deliverables**: single MATLAB script, exported plots, short answers ✔️

---

## 🚀 What’s Inside
- ✅ **One MATLAB script**: `week3_Z_transform.m` (covers A1–A5 end-to-end)
- 🧮 **Symbolic checks** for Z/IZ-transforms (pretty-printed)
- 📈 **Pole-zero** and **frequency response** plots (saved as PNGs)
- 🧠 **Short, practical explanations** you can paste in your report/README

> Tip: Run the script section-by-section (or all at once). Figures auto-save as PNGs for your README/blog.

---

## 📦 Files You’ll Generate (when you run the script)
- `fig_A5_pz.png` — Pole-Zero plot of \(H(z)\)
- `fig_A5_freq.png` — Magnitude & Phase responses
- `fig_A5_signal.png` — (Optional) input/output time-series

You can embed them below once generated:

| Plot | File |
|------|------|
| Pole-Zero | `fig_A5_pz.png` |
| Frequency Response | `fig_A5_freq.png` |
| Signal I/O | `fig_A5_signal.png` |

---

## 🧩 Task Map

### A1 – Finite Sequences → Polynomials
- **Idea**: finite sequences map to **finite polynomials** in \(z^{-1}\).
- **ROC**: entire \(z\)-plane (behaves “nicely”).

### A2 – Infinite Sequences & ROC
- Right-sided \(a^n u[n]\) ⇒ \(X(z)=\frac{1}{1-a z^{-1}}\), **ROC**: \(|z|>|a|\).
- Left-sided \(a^n u[-n-1]\) ⇒ **ROC inside** the pole circle: \(|z|<|a|\).
- **Rule of thumb**: ROC is outside poles for right-sided, inside for left-sided.

### A3 – Linearity & Shifting
- **Linearity**: \(Z\{2x_1-3x_2\}=2X_1-3X_2\).
- **Shift**: \(Z\{x[n-k]\}=z^{-k}X(z)\) (watch ROC endpoints if needed).

### A4 – Inverse Z
- Partial fractions / inspection + ROC ⇒ quick recovery of \(x[n]\).
- Example: \(\frac{1}{1-0.7z^{-1}} \Rightarrow 0.7^n u[n]\).

### A5 – \(H(z)\), Poles/Zeros & Frequency
- Poles near radius ≈ **0.8**, angle ≈ **±60°** ⇒ **resonant peak** near \(\omega\!\approx\!0.33\pi\).
- Behavior: **peaking / narrow band-pass** flavor; stable (poles inside unit circle).

---

## 🛠️ How to Run
1. Open MATLAB.
2. Put `week3_Z_transform.m` in your working folder.
3. Run the script.  
   - PNGs will appear in the same folder.
4. Add files to your Git repo `week3-Z-transform` and push to GitHub.

```bash
git init
git add week3_Z_transform.m *.png README.md
git commit -m "Week 3: Z-transform tasks A1–A5 with plots"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

---

## ✍️ Reflections (short notes you can reuse)
- **ROC intuition**: It’s the set of \(z\) where the Z-sum converges; it wraps around poles depending on time-support (right/left/two-sided).
- **Shifting**: Time shift ⇒ multiply by \(z^{-k}\) in \(Z\)-domain; makes delay chains easy to reason about.
- **Poles vs zeros**: Poles shape **resonance** and stability; zeros carve **spectral notches**.
- **Practice win**: Symbolic `ztrans/iztrans` is a great validator, but inspection (poles/ROC) is faster on exams.

---

## 🧰 Requirements
- MATLAB Symbolic Math Toolbox (for `syms`, `ztrans`, `iztrans`).
- Signal Processing Toolbox (for `zplane`, `freqz`).

> If you’re missing a toolbox, the script will warn and continue where possible.

---

## 🧑‍💻 Credits
Built for **Week 3 — Z-Transform** practice.  
Happy signal-processing! 🎧📡
