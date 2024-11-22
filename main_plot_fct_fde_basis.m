%%%%%%%%%% Plot the Basis Functions of Circlet & Ellipselet
% Written by Zahra Khodabandeh,
% Isfahan University of Medical Sciences, Isfahan, Iran
% Email: shimakhodabandeh@yahoo.com
%
% Input:
% - Circle and Ellipse functions (represented by 'Circle()' and 'Ellipse()')
% - Parameters for generating the Circle and Ellipse shapes
% - Fourier Transform and filtering functions ('fdc', 'fde1', 'fde2', 'fde3', 'fde4')
%
% Output:
% - Plots of Circle and Ellipse shapes, their Fourier transforms, 
%   and results from different filtering operations.

clear all; close all; clc;

% Parameters for generating the shapes
A = 10;  % Amplitude (not used directly in this code)
B = 1;   % Not used, placeholder for future code extension
D = 1;   % Not used, placeholder for future code extension

% Generate an Ellipse and Circle shape
e = double(Ellipse(50, 20, 45, 250, 250, 512, 512));  % Ellipse with specified parameters
c = ~Circle(50, 128, 128, 256, 256);  % Inverse of a Circle with specified parameters

% Display Circle and Ellipse shapes
figure;
title('Circle & Ellipse with their Fourier Transforms');

% Plot the Circle shape
subplot(2,2,1); 
imshow(c); 
colormap jet;
colorbar;
title('Circle');

% Plot the Ellipse shape
subplot(2,2,2); 
imshow(e); 
colormap jet;
colorbar;
title('Ellipse');

% Compute the 2D Fourier Transform of the Circle and Ellipse
C = fft2(c);  % Fourier transform of Circle
Cc = fftshift(C);  % Shift the zero frequency component to the center
E = fft2(e);  % Fourier transform of Ellipse
Ec = fftshift(E);  % Shift the zero frequency component to the center

% Plot the magnitude of the Fourier Transforms of Circle and Ellipse
subplot(2,2,3);
imshow(log(1 + abs(Cc)), []); 
colormap jet;
colorbar;
title('FFT of Circle');

subplot(2,2,4); 
imshow(log(1 + abs(Ec)), []); 
colormap jet;
colorbar;
title('FFT of Ellipse');

% Apply the 'fdc' function to the Circle shape (Fourier Domain Calculation)
[Clc, Gkc] = fdc(c, 4, 50, 'complex');

% Plot the magnitude of the basis functions of the Circle using 'fdc'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(abs(Gkc{k})); 
    colormap jet;
    colorbar;
    title(['Basis Function ' num2str(k)]);
end

% Plot the phase (angle) of the basis functions of the Circle
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(angle(Gkc{k})); 
    colormap jet;
    colorbar;
    title(['Phase of Basis Function ' num2str(k)]);
end

% Apply the 'fde1' function to the Ellipse shape (Fourier Domain Calculation)
[Cle, Gke] = fde1(e, 4, 50, 20, 'complex');

% Plot the magnitude of the basis functions of the Ellipse using 'fde1'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(abs(Gke{k})); 
    colormap jet;
    colorbar;
    title(['Basis Function ' num2str(k)]);
end

% Plot the phase (angle) of the basis functions of the Ellipse using 'fde1'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(angle(Gke{k})); 
    colormap jet;
    colorbar;
    title(['Phase of Basis Function ' num2str(k)]);
end

% Apply the 'fde2' function to the Ellipse shape (Fourier Domain Calculation)
[Cle, Gke] = fde2(e, 4, 50, 20, 'complex');

% Plot the magnitude of the basis functions of the Ellipse using 'fde2'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(abs(Gke{k})); 
    colormap jet;
    colorbar;
    title(['Basis Function ' num2str(k)]);
end

% Plot the phase (angle) of the basis functions of the Ellipse using 'fde2'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(angle(Gke{k})); 
    colormap jet;
    colorbar;
    title(['Phase of Basis Function ' num2str(k)]);
end

% Apply the 'fde3' function to the Ellipse shape (Fourier Domain Calculation)
[Cle, Gke] = fde3(e, 4, 50, 20, 'complex');

% Plot the magnitude of the basis functions of the Ellipse using 'fde3'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(abs(Gke{k})); 
    colormap jet;
    colorbar;
    title(['Basis Function ' num2str(k)]);
end

% Plot the phase (angle) of the basis functions of the Ellipse using 'fde3'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(angle(Gke{k})); 
    colormap jet;
    colorbar;
    title(['Phase of Basis Function ' num2str(k)]);
end

% Apply the 'fde4' function to the Ellipse shape (Fourier Domain Calculation)
[Cle, Gke] = fde4(e, 4, 50, 20, 'complex');

% Plot the magnitude of the basis functions of the Ellipse using 'fde4'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(abs(Gke{k})); 
    colormap jet;
    colorbar;
    title(['Basis Function ' num2str(k)]);
end

% Plot the phase (angle) of the basis functions of the Ellipse using 'fde4'
figure;
for k = 1:4
    subplot(2,2,k);
    imshow(angle(Gke{k})); 
    colormap jet;
    colorbar;
    title(['Phase of Basis Function ' num2str(k)]);
end
