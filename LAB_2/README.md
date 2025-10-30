# 🧮 Lab 2 — 2D Convolution & FIR Filters (Blur, Sharpen, Edges)

This lab treats spatial filtering as **2D convolution** with a kernel (impulse response) \(h[m,n]\).  
You will compare **box vs Gaussian blur**, perform **unsharp masking**, compute **Sobel/Laplacian edges**, and study **boundary handling** and **correlation vs convolution**.


**Figure 1. Impulse response of 3x3 average**

![](lab2_figs/fig1.png)


**Figure 2. Original | Box 3x3 | Box 7x7 | Gaussian (separable)**

![](lab2_figs/fig2.png)


**Figure 3. Original | Blur | High‑freq mask | Sharpened**

![](lab2_figs/fig3.png)


**Figure 4. Sobel Gx | Sobel Gy | Gradient magnitude | Laplacian**

![](lab2_figs/fig4.png)


**Figure 5. Boundary: replicate | symmetric | circular**

![](lab2_figs/fig5.png)


---

## 📦 What this repo includes
- 🖼️ Example outputs (figures above).
- 🧪 MATLAB script demonstrating:
  - Building a **delta image** and visualizing a kernel’s **impulse response**.
  - **Low‑pass filtering**: 3×3 & 7×7 box vs **Gaussian** (with **separable** 1D passes).
  - **Unsharp masking** (blur → high‑freq mask → sharpened image).
  - **Sobel** (Gx, Gy, gradient magnitude) and **Laplacian** edges.
  - **Correlation vs convolution** sanity check.
  - **Boundary modes**: `replicate`, `symmetric`, `circular`.

---

## 🚀 How to run
1. Open MATLAB.
2. Paste your script into a file, e.g. `lab2_2d_convolution.m` and run.
3. If `peppers.png` is not present, the script uses `cameraman.tif` as a fallback.
4. The script displays all figures; capture screenshots for your report.

```matlab
%% Lab 2: 2D Convolution & FIR Filters (Blur, Sharpen, Edges)
close all; clear; clc;
if exist('peppers.png','file')
I0 = imread('peppers.png');
else
I0 = repmat(imread('cameraman.tif'),1,1,3);
end
I = im2double(rgb2gray(I0));

%% 1) Delta image & impulse response
delta = zeros(101,101); delta(51,51) = 1;
h_avg = ones(3,3)/9;
H_vis = conv2(delta, h_avg, 'same');
figure; imagesc(H_vis); axis image off; colorbar; title('Impulse response of 3x3 average');

%% 2) Low-pass: box vs Gaussian, separability
h_box3 = ones(3,3)/9;
h_box7 = ones(7,7)/49;
sigma = 1.2;
g1d = fspecial('gaussian',[1 7], sigma);
h_gauss = g1d'*g1d; % separable
I_box3 = imfilter(I, h_box3, 'replicate');
I_box7 = imfilter(I, h_box7, 'replicate');
I_gauss = imfilter(I, h_gauss, 'replicate');
figure; montage({I, I_box3, I_box7, I_gauss},'Size',[1 4]);
title('Original | Box 3x3 | Box 7x7 | Gaussian (separable)');

%% 3) Unsharp masking (sharpen)
I_blur = imfilter(I, h_gauss, 'replicate');
mask = I - I_blur; % high-frequency
gain = 1.0;
I_sharp = max(min(I + gain*mask,1),0);
figure; montage({I, I_blur, mask, I_sharp},'Size',[1 4]);
title('Original | Blur | High-freq mask | Sharpened');

%% 4) Edges: Sobel & Laplacian
h_sobel_x = fspecial('sobel');
h_sobel_y = h_sobel_x';
Gx = imfilter(I, h_sobel_x, 'replicate');
Gy = imfilter(I, h_sobel_y, 'replicate');
Gmag = hypot(Gx, Gy);
h_lap = fspecial('laplacian', 0.2);
I_lap = imfilter(I, h_lap, 'replicate');
figure; montage({mat2gray(Gx), mat2gray(Gy), mat2gray(Gmag), mat2gray(I_lap)},'Size',[1 4]);
title('Sobel Gx | Sobel Gy | Gradient magnitude | Laplacian');

%% 5) Correlation vs convolution (kernel flip)
C1 = conv2(I, h_box3, 'same');
C2 = imfilter(I, h_box3, 'conv', 'same'); % 'conv' flips internally
diff_val = max(abs(C1(:) - C2(:)));
fprintf('Max difference (conv2 vs imfilter with conv): %g\n', diff_val);

%% 6) Boundary handling
I_rep = imfilter(I, h_box7, 'replicate');
I_sym = imfilter(I, h_box7, 'symmetric');
I_cir = imfilter(I, h_box7, 'circular');
figure; montage({I_rep, I_sym, I_cir},'Size',[1 3]);
title('Boundary: replicate | symmetric | circular');
```

---

## 🧠 Key concepts & talking points
- **Kernel = impulse response** \(h[m,n]\). Convolution computes \(y = x * h\).
- **Gaussian vs box:** Gaussian has a **smoother, more isotropic** frequency response with fewer ringing artifacts; large boxes approximate Gaussian poorly.
- **Separable filters:** If \(h[m,n]=p[m]q[n]\), compute with two 1D passes ⇒ **O(N·K) + O(N·K)** instead of **O(N·K²)**; faster and cache‑friendly.
- **Unsharp masking:** Enhances edges by adding **high‑frequency mask** back to the image (tune `gain`).
- **Sobel/Laplacian:** Gradients highlight **edges**; Laplacian responds to **second‑derivative** zero‑crossings.
- **Boundary modes matter:** `replicate` preserves intensities at borders, `symmetric` mirrors content, `circular` wraps around (periodic assumption).

---

## 🔧 Try these extensions
- Vary `sigma` and kernel sizes; compare blur strength vs detail retention.
- Implement **DoG (Difference of Gaussians)** as an edge detector.
- Add **clipped** vs **normalized** sharpening comparisons.
- Benchmark separable vs non‑separable execution time on large images.

---

## 📜 License
MIT — free for coursework and demos.

---

## 🙌 Credits
Prepared by **Eric Darko**. README assembled for clear GitHub documentation.
