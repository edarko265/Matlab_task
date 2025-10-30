# ✂️ Lab 5 — Edge Detection & Segmentation

This lab applies classic **edge detectors** (Sobel, Prewitt, Canny, LoG) and demonstrates a simple **intensity-based segmentation** pipeline using **Otsu thresholding** followed by **connected-component labeling**.


**Figure 1. Sobel | Prewitt edges**

![](lab5_figs/fig1.png)


**Figure 2. Canny edges**

![](lab5_figs/fig2.png)


**Figure 3. Laplacian of Gaussian edges**

![](lab5_figs/fig3.png)


**Figure 4. Original | Otsu threshold binary mask**

![](lab5_figs/fig4.png)


**Figure 5. Region labeling (colored)**

![](lab5_figs/fig5.png)

---

## 📦 What this repo includes
- 🖼️ Example outputs (figures above).
- 🧪 MATLAB script demonstrating:
  - Gradient-based edges (**Sobel**, **Prewitt**) with binary maps.
  - **Canny** (Gaussian smoothing + gradient + non-max suppression + hysteresis).
  - **LoG** (Laplacian of Gaussian) for blob/edge detection.
  - **Otsu** global threshold to binarize the scene.
  - **bwlabel** + **label2rgb** for region counting/visualization.

---

## 🚀 How to run
1. Open MATLAB.
2. Paste the script into `lab5_edges_segmentation.m` and run.
3. Ensure `peppers.png` is available, or replace with your own image.

```matlab
%% Lab 5: Edge Detection and Segmentation
close all; clear; clc;
I = im2double(rgb2gray(imread('peppers.png')));

%% 1) Basic derivative filters (Sobel, Prewitt)
edges_sobel = edge(I,'Sobel');
edges_prewitt = edge(I,'Prewitt');
figure; montage({edges_sobel, edges_prewitt},'Size',[1 2]);
title('Sobel | Prewitt edges');

%% 2) Canny detector (multi-stage)
edges_canny = edge(I,'Canny',[0.05 0.2]);
figure; imshow(edges_canny); title('Canny edges');

%% 3) Laplacian of Gaussian (LoG)
edges_log = edge(I,'log');
figure; imshow(edges_log); title('Laplacian of Gaussian edges');

%% 4) Edge map → segmentation (Otsu threshold)
level = graythresh(I); % Otsu method
BW = imbinarize(I,level);
figure; montage({I,BW},'Size',[1 2]);
title('Original | Otsu threshold binary mask');

%% 5) Label and visualize regions
[L,num] = bwlabel(BW);
RGB = label2rgb(L);
figure; imshow(RGB); title(['Labeled regions: ',num2str(num)]);
```

---

## 🧠 Notes & talking points
- **Canny** usually yields the **thinnest, cleanest** edges thanks to non-maximum suppression and hysteresis.
- **LoG** is sensitive to noise; pre-smoothing scale controls blob size.
- **Otsu** chooses a global threshold that maximizes inter-class variance; works best with bimodal histograms.
- Region labeling enables **object counting**; refine masks with morphology (`imdilate`, `imerode`, `imopen`, `imclose`).

---

## 🔧 Extensions
- Tune Canny thresholds and Gaussian sigma.
- Try **adaptive thresholding** (`adaptthresh`) for uneven illumination.
- Add **watershed** segmentation on gradient magnitude for touching objects.

---

## 📜 License
MIT — free for coursework and demos.

---

## 🙌 Credits
Prepared by **Eric Darko**. README assembled for clear GitHub documentation.
