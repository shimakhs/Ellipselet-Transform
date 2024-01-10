function I = ifde(Cl, Gkw)
%%% IFDE implements Two-dimensional Inverse Fast Discrete Ellipselet
%     Inputs:
%         Cl: r-by-k cell data contains CT coefficients. r refers to the
%             number of radii and k refers to the number of filters.
%         Gkw: r-by-k cell data contains  filters for computing CT
%         coefficients. generated by fdct2 function.
%     Output:
%         I: Inverse Fast Discrete Ellipselet image.
%

%  written by Zahra Khodabandeh,
%  Isfahan University of Medical Sciences, Isfahan, Iran
%  Email: shimakhodabandeh@yahoo.com
%
% If you use the code provided here, please cite the following paper:
% Khodabandeh Z, Rabbani H, Dehnavi AM, Sarrafzadeh O. The ellipselet transform. J Med Sign Sens 2019;9:145-57.

[row, col] = size(Cl{1,1});
CG = zeros(row,col);
for x=1:size(Cl,1)
    for y=1:size(Cl,2)
        Clw = fft2(Cl{x,y});
        CG = CG+Clw.*conj(Gkw{x,y});
    end
end
I = ifft2(CG);




        