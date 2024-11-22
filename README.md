
# Ellipselet-Based Image Processing: Denoising and Ellipse Detection

This repository contains MATLAB implementations of image denoising and ellipse detection using the **Ellipselet Transform**. The code is designed to process grayscale images by leveraging the unique properties of the Ellipselet transform, a powerful method for feature extraction and noise reduction in images.

---

## Features

### 1. **Ellipselet-Based Denoising**
- Implements soft and hard thresholding for noise reduction.
- Evaluates performance using:
  - **PSNR (Peak Signal-to-Noise Ratio)**
  - **SSIM (Structural Similarity Index Measure)**
- Visualizes original, noisy, and denoised images for comparison.

### 2. **Ellipse Detection**
- Detects ellipses in grayscale images by analyzing subbands generated through the Ellipselet Transform.
- Determines:
  - Center coordinates
  - Dimensions (major and minor axes)
  - Orientation of the detected ellipse.
  - 
## Usage

### 1. **Ellipselet-Based Denoising**
1. Place the input image (e.g., `lena.jpg`) in the working directory.
2. Open the MATLAB file for denoising (`Ellipselet_Denoising.m`).
3. Run the script:
   - The script will:
     1. Load the input image.
     2. Add Gaussian noise to simulate noisy conditions.
     3. Apply the Ellipselet Transform for denoising using selected thresholding techniques.
     4. Compute PSNR and SSIM metrics to evaluate the denoising performance.
     5. Display the original, noisy, and denoised images.

### 2. **Ellipse Detection**
1. Place the input image (e.g., `E5.JPG`) in the working directory.
2. Open the MATLAB file for ellipse detection (`Ellipselet_EllipseDetection.m`).
3. Run the script:
   - The script will:
     1. Load and preprocess the input image.
     2. Apply the Ellipselet Transform to extract subbands.
     3. Identify potential ellipse regions based on Radon transform and thresholding.
     4. Determine the ellipse center, dimensions, and orientation.
     5. Overlay the detected ellipse on the original image.

---

## Citation

If you use the code or methodology provided in this repository, please cite the following paper:

> **Khodabandeh Z, Rabbani H, Dehnavi AM, Sarrafzadeh O. The ellipselet transform. J Med Sign Sens 2019;9:145-57.**

---
