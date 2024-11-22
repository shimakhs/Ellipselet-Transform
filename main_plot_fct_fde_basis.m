% Written by Zahra Khodabandeh,
% Isfahan University of Medical Sciences, Isfahan, Iran
% Email: shimakhodabandeh@yahoo.com
%
% Input:
% - Circle and Ellipse shapes generated using the functions Ellipse() and Circle()
% - Fourier transforms of the Circle and Ellipse
% - Fourier domain decomposition using different methods (fdc, fde1, fde2, fde3, fde4)
%
% Output:
% - Plots of Circle and Ellipse functions and their Fourier transforms
% - Fourier transform magnitude and phase for different decomposition methods (fdc, fde1, fde2, fde3, fde4)

clear all; close all; clc;  % Clear workspace, close all figures, and reset command window

% Parameters for the Ellipse and Circle shapes
A = 10;   % Amplitude parameter for the circle and ellipse
B = 1;    % B parameter for the ellipse
D = 1;    % D parameter for the ellipse

% Generate Ellipse and Circle shapes
e = double(Ellipse(50, 20, 45, 250, 250, 512, 512));  % Ellipse shape
c = ~Circle(50, 128, 128, 256, 256);  % Circle shape (inverted)

% Plot the Circle and Ellipse with their Fourier transforms
figure;
title('Circle & Ellipse with their Fourier Transforms');

% Display Circle image
subplot(221);
imshow(c); colormap jet; colorbar;
title('Circle');

% Display Ellipse image
subplot(222);
imshow(e); colormap jet; colorbar;
title('Ellipse');

% Compute Fourier Transforms of Circle and Ellipse
C = fft2(c);  % Fourier Transform of Circle
Cc = fftshift(C);  % Shift zero frequency to the center

E = fft2(e);  % Fourier Transform of Ellipse
Ec = fftshift(E);  % Shift zero frequency to the center

% Display Fourier Magnitude of Circle
subplot(223);
imshow(log(1 + abs(Cc)), []); colormap jet; colorbar;
title('Fourier Transform of Circle');

% Display Fourier Magnitude of Ellipse
subplot(224);
imshow(log(1 + abs(Ec)), []); colormap jet; colorbar;
title('Fourier Transform of Ellipse');

% Fourier Domain Decomposition (fdc) for Circle
[Clc, Gkc] = fdc(c, 4, 50, 'complex');  % Decompose Circle using 'complex' method

% Display magnitude of decomposition results for Circle
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(abs(Gkc{k})); colormap jet; colorbar;
    title(['Magnitude of Gkc - Component ' num2str(k)]);
end

% Display phase of decomposition results for Circle
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(angle(Gkc{k})); colormap jet; colorbar;
    title(['Phase of Gkc - Component ' num2str(k)]);
end

% Fourier Domain Decomposition (fde1) for Ellipse
[Cle, Gke] = fde1(e, 4, 50, 20, 'complex');  % Decompose Ellipse using 'complex' method

% Display magnitude of decomposition results for Ellipse (fde1)
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(abs(Gke{k})); colormap jet; colorbar;
    title(['Magnitude of Gke (fde1) - Component ' num2str(k)]);
end

% Display phase of decomposition results for Ellipse (fde1)
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(angle(Gke{k})); colormap jet; colorbar;
    title(['Phase of Gke (fde1) - Component ' num2str(k)]);
end

% Fourier Domain Decomposition (fde2) for Ellipse
[Cle, Gke] = fde2(e, 4, 50, 20, 'complex');  % Decompose Ellipse using 'complex' method

% Display magnitude of decomposition results for Ellipse (fde2)
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(abs(Gke{k})); colormap jet; colorbar;
    title(['Magnitude of Gke (fde2) - Component ' num2str(k)]);
end

% Display phase of decomposition results for Ellipse (fde2)
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(angle(Gke{k})); colormap jet; colorbar;
    title(['Phase of Gke (fde2) - Component ' num2str(k)]);
end

% Fourier Domain Decomposition (fde3) for Ellipse
[Cle, Gke] = fde3(e, 4, 50, 20, 'complex');  % Decompose Ellipse using 'complex' method

% Display magnitude of decomposition results for Ellipse (fde3)
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(abs(Gke{k})); colormap jet; colorbar;
    title(['Magnitude of Gke (fde3) - Component ' num2str(k)]);
end

% Display phase of decomposition results for Ellipse (fde3)
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(angle(Gke{k})); colormap jet; colorbar;
    title(['Phase of Gke (fde3) - Component ' num2str(k)]);
end

% Fourier Domain Decomposition (fde4) for Ellipse
[Cle, Gke] = fde4(e, 4, 50, 20, 'complex');  % Decompose Ellipse using 'complex' method

% Display magnitude of decomposition results for Ellipse (fde4)
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(abs(Gke{k})); colormap jet; colorbar;
    title(['Magnitude of Gke (fde4) - Component ' num2str(k)]);
end

% Display phase of decomposition results for Ellipse (fde4)
figure;
for k = 1:4
    subplot(2, 2, k);
    imshow(angle(Gke{k})); colormap jet; colorbar;
    title(['Phase of Gke (fde4) - Component ' num2str(k)]);
end
