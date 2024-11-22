%--------------------------------------------------------------------------
% Input:
% - E5.JPG: The input image containing ellipses to be detected.
%
% Output:
% - Detected_Ellipse: The detected ellipse overlaid on the original image.
%
% Description:
% This code applies the Ellipselet Transform to detect ellipses in an image.
% It identifies ellipse parameters including center, orientation, and dimensions.
%
% Author:
% Zahra Khodabandeh,
% Isfahan University of Medical Sciences, Isfahan, Iran
% Email: shimakhodabandeh@yahoo.com
%
% Reference:
% Khodabandeh Z, Rabbani H, Dehnavi AM, Sarrafzadeh O. The ellipselet transform.
% J Med Sign Sens 2019;9:145-57.
%--------------------------------------------------------------------------

clear all; close all; clc;

%% Step 1: Read the Input Image
I = imread('E5.JPG'); % Load the input image.
f = rgb2gray(I);      % Convert the image to grayscale.
f = im2double(f);     % Normalize the image to the [0, 1] range.
figure; imshow(f);    % Display the grayscale image.

%% Step 2: Apply the Ellipselet Transform
% Define the number of filters and ellipse dimensions.
N = 4;  % Number of filters.
a1 = 50; % Semi-major axis of the ellipses.
b1 = 20; % Semi-minor axis of the ellipses.

% Apply the Ellipselet Transform using custom functions (fde1, fde2, etc.).
[Cle1, Gke1] = fde1(f, N, a1, b1, 'abs');
[Cle2, Gke2] = fde2(f, N, a1, b1, 'abs');
[Cle3, Gke3] = fde3(f, N, a1, b1, 'abs');
[Cle4, Gke4] = fde4(f, N, a1, b1, 'abs');

% Store the transform results in a cell array for organization.
basis = cell(1, 4);
basis{1, 1} = {Cle1, Gke1};
basis{1, 2} = {Cle2, Gke2};
basis{1, 3} = {Cle3, Gke3};
basis{1, 4} = {Cle4, Gke4};

%% Step 3: Process Subbands and Generate Binary Masks
% Create binary masks for each subband and visualize them.
figure;
k5 = 1; % Subplot index.
for i = 1:size(basis, 1)
    for j = 1:size(basis, 2)
        for i1 = 1:size(Cle1, 1)
            for j1 = 1:size(Cle1, 2)
                % Normalize, binarize, and apply morphological closing.
                normalized = (basis{i, j}{1, 1}{i1, j1} - min(basis{i, j}{1, 1}{i1, j1}(:))) ...
                              / (max(basis{i, j}{1, 1}{i1, j1}(:)) - min(basis{i, j}{1, 1}{i1, j1}(:)));
                binary = im2bw(normalized, 0.2);
                se = strel('disk', 25);
                closed = imclose(binary, se);

                % Store and visualize the processed subbands.
                kk{i, j}{1, 1}{i1, j1} = closed;
                subplot(4, 4, k5); imshow(closed);
                k5 = k5 + 1;
            end
        end
    end
end

%% Step 4: Analyze Orientation Using Radon Transform
% Analyze the orientation of detected features using Radon Transform.
figure;
angles = [90, 0, 45, -45]; % Predefined angles.
Theta = cell(1, 4);
for t = 1:4
    subplot(1, 4, t);
    R = radon(kk{1, t}{1, 1}{1, t}, angles(t));
    med_filtered = medfilt1(R);
    plot(med_filtered);

    % Detect peaks and determine orientation threshold.
    peaks = findpeaks(med_filtered);
    max_peak = max(med_filtered);
    threshold = 0.65 * max_peak;
    above_threshold = med_filtered >= threshold;

    % Determine the orientation based on peak properties.
    if any(above_threshold)
        Theta{t} = angles(t);
    else
        Theta{t} = 'N/A';
    end
end

%% Step 5: Detect Ellipse Center and Dimensions
% Combine subband information to find the ellipse center.
AA = cell2mat(basis{1, 4}{1, 1}(1, 1)); % Use -45 degree basis.
Th = 0.8 * max(AA(:));
[rowCle, colCle] = find(AA >= Th);

% Divide rows into two groups to find two peak centers.
meanRow = mean(rowCle);
[row1, ~] = find(rowCle <= meanRow);
[row2, ~] = find(rowCle > meanRow);

% Identify the maximum coefficients in each group.
[max1, idx1] = max(AA(rowCle(row1), colCle(row1)));
[max2, idx2] = max(AA(rowCle(row2), colCle(row2)));

% Calculate the ellipse center.
center_x = mean([rowCle(idx1), rowCle(idx2)]);
center_y = mean([colCle(idx1), colCle(idx2)]);
ellipse_center = [center_x, center_y];

% Estimate ellipse dimensions from projections.
R1 = radon(f, cell2mat(Theta(4))); % -45 degree orientation.
R2 = radon(f, cell2mat(Theta(4)) + 90); % Perpendicular direction.

% Calculate major and minor axes.
major_axis = (max(find(R1)) - min(find(R1))) / 2;
minor_axis = (max(find(R2)) - min(find(R2))) / 2;

%% Step 6: Overlay the Detected Ellipse
Detected_Ellipse = Ellipse(major_axis, minor_axis, cell2mat(Theta(4)), ...
                           ellipse_center(1), ellipse_center(2), 512, 512);

figure; imshow(f); hold on;
contour(Detected_Ellipse, 'r');
title('Detected Ellipse');
