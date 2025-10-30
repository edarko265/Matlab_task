# 🌊 Lab 3 — Frequency‑Domain Filtering with `fft2`

Explore image filtering in the **frequency domain** using 2‑D FFTs. Compare **ideal** vs **Gaussian** low‑pass, build a **Gaussian high‑pass**, and verify the **convolution theorem** by matching spatial and frequency‑domain Gaussian filtering.


**Figure 1. Image | Log‑magnitude spectrum (centered)**

![](lab3_figs/fig1.png)


**Figure 2. Original | Ideal LP | Gaussian LP (ringing vs smooth)**

![](lab3_figs/fig2.png)


**Figure 3. Original | Gaussian High‑pass result**

![](lab3_figs/fig3.png)


**Figure 4. Spatial Gaussian LP | Frequency‑domain Gaussian LP**

![](lab3_figs/fig4.png)


---

## 📦 What this repo includes
- 🖼️ Example outputs (figures below).
- 🧪 MATLAB script demonstrating:
  - Computing and visualizing the **log‑magnitude spectrum** with `fftshift`.
  - Designing **Ideal** and **Gaussian** **low‑pass** masks in frequency.
  - Implementing a **Gaussian high‑pass** via complement.
  - **Spatial vs frequency** Gaussian LP comparison (they should closely match).

---

## 🚀 How to run
1. Open MATLAB.
2. Paste the script into a file, e.g. `lab3_frequency_domain.m`, and run.
3. If `peppers.png` is not available, the script falls back to `cameraman.tif`.

```matlab
%% Lab 3: Frequency-Domain Filtering with fft2
close all; clear; clc;
if exist('peppers.png','file')
I0 = imread('peppers.png');
else
I0 = repmat(imread('cameraman.tif'),1,1,3);
end
I = im2double(rgb2gray(I0));
[M,N] = size(I);

%% 1) Magnitude spectrum (log-scale)
F = fft2(I);
Fshift = fftshift(F);
S = log(1 + abs(Fshift));
figure;
subplot(1,2,1); imshow(I,[]); title('Image');
subplot(1,2,2); imshow(S,[]); title('Log-magnitude spectrum (centered)');

%% 2) Ideal & Gaussian Low-pass in frequency
[u,v] = meshgrid( -floor(N/2):ceil(N/2)-1, -floor(M/2):ceil(M/2)-1 );
D = sqrt(u.^2 + v.^2);
D0 = 40; % cutoff radius
H_ideal_LP = double(D <= D0); % ideal circular LP
sigma = 20;
H_gauss_LP = exp(-(D.^2) / (2*sigma^2));

%% 3) Apply LP filters in frequency domain
G_ideal = ifft2( ifftshift( H_ideal_LP .* Fshift ) );
G_gauss = ifft2( ifftshift( H_gauss_LP .* Fshift ) );
figure; montage({I, real(G_ideal), real(G_gauss)}, 'Size', [1 3]);
title('Original | Ideal LP | Gaussian LP (ringing vs smooth)');

%% 4) High-pass via complement
H_gauss_HP = 1 - H_gauss_LP;
G_hp = real( ifft2( ifftshift( H_gauss_HP .* Fshift ) ) );
G_hp = mat2gray(G_hp);
figure; montage({I, G_hp}, 'Size', [1 2]);
title('Original | Gaussian High-pass result');

%% 5) Compare spatial vs frequency-domain Gaussian LP
g1d = fspecial('gaussian',[1 7], 1.2);
I_spatial_gauss = imfilter(I, g1d'*g1d, 'replicate');
figure; montage({I_spatial_gauss, real(G_gauss)}, 'Size', [1 2]);
title('Spatial Gaussian LP | Frequency-domain Gaussian LP');
```

---

## 🧠 Key concepts
- **Convolution theorem:** Spatial convolution ⇔ frequency‑domain multiplication. Gaussian LP in either domain should **match** (modulo padding/edges).
- **Ideal LP ringing:** A sharp cutoff has non‑localized impulse response (sinc‑like) → **Gibbs ripples** near edges in the image.
- **`fftshift`:** Moves DC to the **center** of the spectrum so low frequencies appear in the middle, high frequencies toward the corners.

---

## 🔧 Try these extensions
- Vary `D0` and `sigma` to see blur strength and ringing vs smoothness.
- Use **padding** before FFT to mitigate circular convolution artifacts.
- Build **Band‑pass** and **Notch** filters (e.g., remove periodic noise).

---

## 📜 License
MIT — free for coursework and demos.

---

## 🙌 Credits
Prepared by **Eric Darko**. README assembled for clear GitHub documentation.
