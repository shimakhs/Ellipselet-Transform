% Ellipse Denoising using Fourier Domain Decomposition (FDE)
% 
% Input:
% - f: Input image (2D matrix)
% - N: Number of decomposition levels
% - a1, b1: Parameters for FDE decomposition
% - Sigma: Noise standard deviation for thresholding
% - method: Thresholding method ('s' for soft thresholding)
% 
% Output:
% - f: Denoised image

function f = Ellipse_denoising(f, N, a1, b1, Sigma, method) 

% Convert input image to double precision
f = double(f);

% Apply Fourier Domain Decomposition (FDE) for 4 levels
% Level 1
[Cle1, Gke1] = fde1(f, N, a1, b1, 'complex');
% Level 2
[Cle2, Gke2] = fde2(f, N, a1, b1, 'complex');
% Level 3
[Cle3, Gke3] = fde3(f, N, a1, b1, 'complex');
% Level 4
[Cle4, Gke4] = fde4(f, N, a1, b1, 'complex');

%% Calculate threshold for each subband (for denoising)
Nsig = Sigma;  % Noise standard deviation

% Method for thresholding ('s' for soft thresholding)
method = 's';

% Indices for selecting subbands (real and imaginary components)
c = [1, 3, 4];

% Initialize cell arrays to hold real and imaginary parts for each level
for x = 1:size(Cle1, 1)
    for y = 1:3
        rel1{x, c(y)}(:,:) = real(Cle1{x, c(y)}(:,:));  % Real part of the decomposition
        img1{x, c(y)}(:,:) = imag(Cle1{x, c(y)}(:,:));  % Imaginary part of the decomposition
    end
end

% Denoising by thresholding the coefficients
for x = 1:size(Cle1, 1)
    for y = 1:3
        % Calculate the standard deviation of real and imaginary parts
        Ssig_rel1(x, c(y)) = sqrt(max((std2(rel1{x, c(y)})^2 - Nsig^2), eps));
        Thresh_rel1(x, c(y)) = (Nsig^2) / Ssig_rel1(x, c(y));
        
        Ssig_img1(x, c(y)) = sqrt(max((std2(img1{x, c(y)})^2 - Nsig^2), eps));
        Thresh_img1(x, c(y)) = (Nsig^2) / Ssig_img1(x, c(y));

        % Apply soft thresholding
        Cln11{x, c(y)} = wthresh(rel1{x, c(y)}, method, Thresh_rel1(x, c(y)));
        Cln21{x, c(y)} = wthresh(img1{x, c(y)}, method, Thresh_img1(x, c(y)));

        % Reconstruct the complex coefficient
        Cln1{x, c(y)} = Cln11{x, c(y)} + 1i * Cln21{x, c(y)};
    end
end

% Preserve the second subband (the 2nd coefficient is untouched)
for x = 1:size(Cle1, 1)
    Cln1{x, 2} = Cle1{x, 2};
end

% Perform inverse of the FDE (Inverse Fourier Transform)
f1 = abs(ifde(Cln1, Gke1));  % Reconstructed image from level 1 decomposition

%% Repeat the process for the second level
for x = 1:size(Cle2, 1)
    for y = 1:3
        rel2{x, c(y)}(:,:) = real(Cle2{x, c(y)}(:,:));
        img2{x, c(y)}(:,:) = imag(Cle2{x, c(y)}(:,:));
    end
end

% Denoising for the second level
for x = 1:size(Cle2, 1)
    for y = 1:3
        Ssig_rel2(x, c(y)) = sqrt(max((std2(rel2{x, c(y)})^2 - Nsig^2), eps));
        Thresh_rel2(x, c(y)) = (Nsig^2) / Ssig_rel2(x, c(y));
        
        Ssig_img2(x, c(y)) = sqrt(max((std2(img2{x, c(y)})^2 - Nsig^2), eps));
        Thresh_img2(x, c(y)) = (Nsig^2) / Ssig_img2(x, c(y));

        % Apply soft thresholding
        Cln12{x, c(y)} = wthresh(rel2{x, c(y)}, method, Thresh_rel2(x, c(y)));
        Cln22{x, c(y)} = wthresh(img2{x, c(y)}, method, Thresh_img2(x, c(y)));

        % Reconstruct the complex coefficient
        Cln2{x, c(y)} = Cln12{x, c(y)} + 1i * Cln22{x, c(y)};
    end
end

% Preserve the second subband
for x = 1:size(Cle2, 1)
    Cln2{x, 2} = Cle2{x, 2};
end

% Perform inverse of the FDE (Inverse Fourier Transform)
f2 = abs(ifde(Cln2, Gke2));  % Reconstructed image from level 2 decomposition

%% Repeat the process for the third level (same structure)
for x = 1:size(Cle3, 1)
    for y = 1:3
        rel3{x, c(y)}(:,:) = real(Cle3{x, c(y)}(:,:));
        img3{x, c(y)}(:,:) = imag(Cle3{x, c(y)}(:,:));
    end
end

% Denoising for the third level
for x = 1:size(Cle3, 1)
    for y = 1:3
        Ssig_rel3(x, c(y)) = sqrt(max((std2(rel3{x, c(y)})^2 - Nsig^2), eps));
        Thresh_rel3(x, c(y)) = (Nsig^2) / Ssig_rel3(x, c(y));
        
        Ssig_img3(x, c(y)) = sqrt(max((std2(img3{x, c(y)})^2 - Nsig^2), eps));
        Thresh_img3(x, c(y)) = (Nsig^2) / Ssig_img3(x, c(y));

        % Apply soft thresholding
        Cln13{x, c(y)} = wthresh(rel3{x, c(y)}, method, Thresh_rel3(x, c(y)));
        Cln23{x, c(y)} = wthresh(img3{x, c(y)}, method, Thresh_img3(x, c(y)));

        % Reconstruct the complex coefficient
        Cln3{x, c(y)} = Cln13{x, c(y)} + 1i * Cln23{x, c(y)};
    end
end

% Preserve the second subband
for x = 1:size(Cle3, 1)
    Cln3{x, 2} = Cle3{x, 2};
end

% Perform inverse of the FDE (Inverse Fourier Transform)
f3 = abs(ifde(Cln3, Gke3));  % Reconstructed image from level 3 decomposition

%% Repeat the process for the fourth level (same structure)
for x = 1:size(Cle4, 1)
    for y = 1:3
        rel4{x, c(y)}(:,:) = real(Cle4{x, c(y)}(:,:));
        img4{x, c(y)}(:,:) = imag(Cle4{x, c(y)}(:,:));
    end
end

% Denoising for the fourth level
for x = 1:size(Cle4, 1)
    for y = 1:3
        Ssig_rel4(x, c(y)) = sqrt(max((std2(rel4{x, c(y)})^2 - Nsig^2), eps));
        Thresh_rel4(x, c(y)) = (Nsig^2) / Ssig_rel4(x, c(y));
        
        Ssig_img4(x, c(y)) = sqrt(max((std2(img4{x, c(y)})^2 - Nsig^2), eps));
        Thresh_img4(x, c(y)) = (Nsig^2) / Ssig_img4(x, c(y));

        % Apply soft thresholding
        Cln14{x, c(y)} = wthresh(rel4{x, c(y)}, method, Thresh_rel4(x, c(y)));
        Cln24{x, c(y)} = wthresh(img4{x, c(y)}, method, Thresh_img4(x, c(y)));

        % Reconstruct the complex coefficient
        Cln4{x, c(y)} = Cln14{x, c(y)} + 1i * Cln24{x, c(y)};
    end
end

% Preserve the second subband
for x = 1:size(Cle4, 1)
    Cln4{x, 2} = Cle4{x, 2};
end

% Perform inverse of the FDE (Inverse Fourier Transform)
f4 = abs(ifde(Cln4, Gke4));  % Reconstructed image from level 4 decomposition

% Combine the results from all levels
f = f1 + f2 + f3 + f4;  % Final denoised image
