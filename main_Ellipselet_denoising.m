%  written by Zahra Khodabandeh,
%  Isfahan University of Medical Sciences, Isfahan, Iran
%  Email: shimakhodabandeh@yahoo.com
%
% If you use the code provided here, please cite the following paper:
% Khodabandeh Z, Rabbani H, Dehnavi AM, Sarrafzadeh O. The ellipselet transform. J Med Sign Sens 2019;9:145-57.

%%%%%% This code uses Ellipselet for image denoising
clear all; close all; clc;
% read the image
I = imread('lena.jpg');
I = double(I);
% Add noise
Sigma =25;
NN = Sigma*randn(size(I));
I1 = I + NN;
figure;imshow(I,[]);title('main image')
figure;imshow(I1,[]);title('noisy image')
%% Denoising using FCT
N = 4;                      % number of filters
a1 = 20;
b1 = 5;
method = 's';        % method could be 's'/'h' denotes for soft/hard thresholding
denoised = Ellipse_denoising(I1,N,a1,b1,Sigma,method); 
figure,                                                                                                                                                                                                                                                              
% subplot 121,imshow(f1,[]),title('Original image')
% subplot 122,
imshow(denoised,[]),title('Denoised image with Ellipselet(thresholded on [1,3,4])')
denoised_normal = (denoised-min(min(denoised)))/max(max(denoised)-min(min(denoised)));
I5 = (I1-min(min(I1)))/max(max(I1)-min(min(I1)));
I4 = (I-min(min(I)))/max(max(I)-min(min(I)));

P_nosisy = psnr_me(I4,I5);
p1_denosied = psnr_me(I4,denoised_normal);
%% calculating SSIM
K = [0.01 0.03];
window = fspecial('gaussian', 11, 1.5);
L = 1;
[ssim_noisy, ssim_map] = ssim(I4, I5 , K, window, L);
[ssim_denoised, ssim_map2] = ssim(I4, denoised_normal, K, window, L);