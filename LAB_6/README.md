# 🧠 Lab 6 — Mini DSP Image Pipeline

This mini-project integrates **core DSP–image processing concepts** — spatial filtering, contrast enhancement, frequency-domain filtering, and edge extraction — into one short, complete workflow.

---

## 🎯 Objective

Design a compact **MATLAB pipeline** that:
- Loads a chosen image (e.g., object, face, or landscape),
- Removes noise using spatial filters,
- Enhances contrast,
- Extracts edges or frequency components,
- Visualizes and interprets all stages together.

---

## ⚙️ Workflow Overview

1. **Load image**
   - Converts RGB to grayscale.
   - Ensures normalized intensity range (0–1).

2. **Denoising**
   - Uses a 3×3 median filter to suppress impulsive noise while preserving edges.

3. **Contrast Enhancement**
   - Applies `imadjust(I,[0.2 0.8],[0 1])` to stretch intensities and improve local detail.

4. **Edge Extraction**
   - Uses Canny detector with `[0.1 0.25]` thresholds → thin, connected edges.

5. **Frequency-Domain Low-Pass Filtering**
   - Computes the 2D FFT, multiplies by a circular mask (radius = 60 px),
     and reconstructs via inverse FFT.
   - Removes high-frequency texture and noise.

6. **Visualization**
   - Displays all steps together:
     ```
     Original | Denoised | Enhanced | Edges | LP result
     ```

---

## 📊 Example Outputs

**Figure 1 – Pipeline attempt 1**

![](lab6_figs/Pipeline_Attempt_1.png)

**Figure 2 – Pipeline attempt 2**

![](lab6_figs/Pipeline_Attempt_2.png)

---

## 💻 MATLAB Code

```matlab
%% Lab 6: Mini Project – Your Image Pipeline
close all; clear; clc;

% 1) Load image (object, face, landscape)
I = im2double(rgb2gray(imread('globe.jpg','jpg','AutoOrient',true)));

% 2) Pre-process: noise removal
I_filt = medfilt2(I,[3 3]);

% 3) Enhance contrast
I_enh = imadjust(I_filt,[0.2 0.8],[0 1]);

% 4) Extract features (edges)
edges = edge(I_enh,'Canny',[0.1 0.25]);

% 5) Frequency-domain mask
F = fftshift(fft2(I_enh));
[M,N] = size(F);
[u,v] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
H = double(sqrt(u.^2+v.^2)<60);
I_lp = real(ifft2(ifftshift(F.*H)));

% 6) Visualization
figure; montage({I, I_filt, I_enh, edges, I_lp},'Size',[1 5]);
title('Original | Denoised | Enhanced | Edges | LP result');
```

---

## 🧩 DSP Concepts Illustrated

| Concept | MATLAB Operation | Effect |
|----------|------------------|--------|
| **Spatial filtering** | `medfilt2` | Removes noise (impulse suppression) |
| **Point enhancement** | `imadjust` | Expands useful intensity range |
| **Edge detection** | `edge(...,'Canny')` | Gradient-based feature extraction |
| **Frequency filtering** | `fft2`, `ifft2` | Attenuates high frequencies |
| **Visualization** | `montage` | Compares each processing stage |

---

## 🔍 Reflections & Discussion

- **Denoising**: Median filtering effectively removes small noise while retaining edge definition.  
- **Enhancement**: Contrast stretching improves visual clarity but may amplify background noise.  
- **Edges**: Canny provides thin and stable contours; threshold tuning affects sensitivity.  
- **Low-pass filtering**: Removes unwanted detail but can blur edges — ideal LP causes slight ringing artifacts.  
- **Overall**: The pipeline is modular and expandable — e.g., you can add sharpening, adaptive thresholding, or morphological cleanup.

---

## 🧱 Possible Improvements
- Replace ideal LP with Gaussian LP to avoid ringing.
- Use adaptive histogram equalization (`adapthisteq`).
- Combine frequency and spatial results for hybrid filtering.
- Add object counting via `bwlabel` after edge detection.

---

## 📦 Output Directory

All generated results (e.g., `lab6_outputs/`) may include:
```
01_original.png
02_denoised.png
03_enhanced.png
04_edges.png
05_lowpass.png
pipeline_fig.png
```

---

## 📜 License
MIT — free for educational and research purposes.

---

## 🙌 Credits
Prepared by **Eric Darko**.  
README assembled for GitHub submission and documentation clarity.
