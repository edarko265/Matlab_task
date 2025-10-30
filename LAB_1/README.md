# 🖼️ Lab 1 — Image as a 2D Signal (Sampling, Quantization, Histograms, Enhancement)

This MATLAB exercise treats an image as a **2D discrete-time signal** and explores how **sampling, quantization, histogram operations, and nonlinear mappings** affect appearance and information content.


**Figure 1. Original RGB**

![](lab1_figs/fig1.png)


**Figure 2. Grayscale**

![](lab1_figs/fig2.png)


**Figure 3. Quantization: 8-bit vs ~6-bit vs ~4-bit**

![](lab1_figs/fig3.png)


**Figure 4. Histogram (original vs stretched)**

![](lab1_figs/fig4.png)


**Figure 5. Original | Normalized | Contrast-stretched**

![](lab1_figs/fig5.png)


**Figure 6. Gamma: original | γ=0.6 | γ=1.6**

![](lab1_figs/fig6.png)


**Figure 7. Sampling/Aliasing: original | downsampled | upscaled**

![](lab1_figs/fig7.png)


---

## 📦 What this repo contains
- ✅ Self‑contained MATLAB script covering:
  - **Loading & inspection** of an RGB image; luminance conversion to grayscale.
  - **Quantization** at 8‑bit, ~6‑bit, and ~4‑bit levels and a visual **montage**.
  - **Histograms** (original vs contrast‑stretched) and intensity **normalization**.
  - **Gamma correction** (γ<1 brightens, γ>1 darkens).
  - **Sampling & aliasing** demo by aggressive downsample→upsample using nearest neighbor.
- 🖼️ Example output figures (see below).

> If *peppers.png* is missing, the script falls back to **cameraman.tif**.

---

## 🚀 How to run
1. Open MATLAB.
2. Paste the script into a file (e.g., `lab1_image_2D.m`) and run.
3. Watch the created figures and console output.

```matlab
%% Lab 1: Image as a 2D Signal (Sampling, Quantization, Histograms, Enhancement)
close all; clear; clc;

%% 0) Load and inspect an image
if exist('peppers.png','file')
    I_rgb = imread('peppers.png');
else
    I_rgb = repmat(imread('cameraman.tif'),1,1,3); % fallback
end
figure; imshow(I_rgb); title('Original RGB');

% Convert to grayscale (luminance)
if size(I_rgb,3)==3
    I = rgb2gray(I_rgb);
else
    I = I_rgb;
end
figure; imshow(I); title('Grayscale');

% Basic info
fprintf('Class: %s | Range: [%g, %g] | Size: %d x %d\n', class(I), double(min(I(:))), double(max(I(:))), size(I,1), size(I,2));

%% 1) Quantization and dynamic range
I8 = I; % 8-bit (0..255)
I6 = uint8(floor(double(I)/4)*4); % ~6 bits (step 4)
I4 = uint8(floor(double(I)/16)*16); % ~4 bits (step 16)
figure; montage({I8,I6,I4},'Size',[1 3]);
title('Quantization: 8-bit vs ~6-bit vs ~4-bit');

%% 2) Histogram and contrast stretching
figure;
subplot(1,2,1); imhist(I); title('Histogram (original)');
I_norm = mat2gray(I); % scales to [0,1]
I_stretch = imadjust(I,[0.2 0.8],[0 1]); % stretch mid-range
subplot(1,2,2); imhist(I_stretch); title('Histogram (stretched)');
figure; montage({I, im2uint8(I_norm), im2uint8(I_stretch)},'Size',[1 3]);
title('Original | Normalized | Contrast-stretched');

%% 3) Gamma correction (nonlinear amplitude scaling)
I_gamma_low = imadjust(I,[],[],0.6); % gamma < 1 brightens
I_gamma_high = imadjust(I,[],[],1.6); % gamma > 1 darkens
figure; montage({I,I_gamma_low,I_gamma_high},'Size',[1 3]);
title('Gamma: original | gamma=0.6 | gamma=1.6');

%% 4) Sampling and aliasing (downsample then upsample)
scale = 0.1; % 10% of size
I_small = imresize(I, scale, 'nearest'); % naive sampling
I_back = imresize(I_small, size(I), 'nearest');
figure; montage({I, I_small, I_back}, 'Size', [1 3]);
title('Original | Aggressively downsampled | Upscaled back (aliasing artifacts)');

%% 5) OPTIONAL: Moiré demo
% If you have a striped/high-frequency texture image, repeat Section 4 and
% observe interference patterns (moiré).

%% 6) Short reflections (add to your report)
% 1) Relate bit-depth to visible banding/posterization you observed.
% 2) How does contrast stretching change the histogram and visibility of details?
% 3) Explain why aggressive downsampling causes aliasing (reference Nyquist).
```

---

## 🧠 Learning takeaways
- **Bit‑depth ↓ ⇒ quantization step ↑** ⇒ more **banding/posterization** in smooth regions.
- **Contrast stretching** remaps a middle intensity range to **full dynamic range**, improving visibility of midtones; histogram spreads toward 0–255.
- **Gamma** is a **nonlinear** power‑law mapping: γ<1 boosts shadows; γ>1 boosts highlights.
- **Aliasing** happens when downsampling below **Nyquist**; high‑frequency content folds into lower frequencies, producing blockiness/false patterns.

---

## 🔧 Extensions
- Try `imresize` with `'bilinear'` and `'bicubic'` to compare resampling kernels.
- Replace `peppers.png` with your own photo—observe how textures respond.
- Add **histogram equalization** (`histeq`) for an alternative contrast method.

---

## 📜 License
MIT — use freely in coursework and labs.

---

## 🙌 Credits
Prepared by **Eric Darko**. README authored to document the lab clearly.
