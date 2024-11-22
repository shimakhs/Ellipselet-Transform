% Written by Zahra Khodabandeh,
% Isfahan University of Medical Sciences, Isfahan, Iran
% Email: shimakhodabandeh@yahoo.com
%
% If you use the code provided here, please cite the following paper:
% Khodabandeh Z, Rabbani H, Dehnavi AM, Sarrafzadeh O. The ellipselet transform. 
% J Med Sign Sens 2019;9:145-57.
%
% Input:
% - A grayscale image 'I' (e.g., 'lena.jpg')
% - Sigma (standard deviation of noise to be added)
% - Ellipselet transform parameters N, a1, b1
% - Thresholding method ('s' for soft or 'h' for hard)
%
% Output:
% - Denoised image after applying Ellipselet transform and thresholding
% - PSNR (Peak Signal-to-Noise Ratio) and SSIM (Structural Similarity Index) between 
%   original, noisy, and denoised images

%%%%%% This code uses Ellipselet for image denoising

clear all; close all; clc;

% Read the input image (convert to double for processing)
I = imread('lena.jpg');
I = double(I);  % Convert image to double precision for mathematical operations

% Add Gaussian noise to the image
Sigma = 25;  % Standard deviation of the noise
NN = Sigma * randn(size(I));  % Generate random noise with the specified sigma
I1 = I + NN;  % Add noise to the original image

% Display the original and noisy images
figure;
imshow(I, []);  % Display original image
title('Original Image');

figure;
imshow(I1, []);  % Display noisy image
title('Noisy Image');

%% Denoising using Ellipselet Transform
N = 4;  % Number of filters to be used in the Ellipselet transform
a1 = 20;  % First parameter for the Ellipselet transform (shape of the filters)
b1 = 5;   % Second parameter for the Ellipselet transform (shape of the filters)
method = 's';  % Thresholding method ('s' for soft thresholding, 'h' for hard thresholding)

% Apply Ellipselet denoising method
denoised = Ellipse_denoising(I1, N, a1, b1, Sigma, method);

% Display the denoised image
figure;
imshow(denoised, []);  % Display denoised image
title('Denoised Image with Ellipselet (thresholded on [1,3,4])');

% Normalize the denoised, noisy, and original images for comparison
denoised_normal = (denoised - min(min(denoised))) / max(max(denoised) - min(min(denoised)));
I5 = (I1 - min(min(I1))) / max(max(I1) - min(min(I1)));  % Normalize noisy image
I4 = (I - min(min(I))) / max(max(I) - min(min(I)));  % Normalize original image

% Calculate PSNR (Peak Signal-to-Noise Ratio) for comparison
P_nosisy = psnr_me(I4, I5);  % PSNR between original and noisy image
p1_denosied = psnr_me(I4, denoised_normal);  % PSNR between original and denoised image

% Calculate SSIM (Structural Similarity Index) for comparison
K = [0.01 0.03];  % SSIM constants for luminance and contrast comparison
window = fspecial('gaussian', 11, 1.5);  % Gaussian window for SSIM calculation
L = 1;  % Dynamic range of the image (1 for normalized images)

% SSIM between noisy and original image
[ssim_noisy, ssim_map] = ssim(I4, I5, K, window, L);

% SSIM between denoised and original image
[ssim_denoised, ssim_map2] = ssim(I4, denoised_normal, K, window, L);

% Display PSNR and SSIM results
disp(['PSNR (Noisy): ', num2str(P_nosisy)]);
disp(['PSNR (Denoised): ', num2str(p1_denosied)]);
disp(['SSIM (Noisy): ', num2str(ssim_noisy)]);
disp(['SSIM (Denoised): ', num2str(ssim_denoised)]);
