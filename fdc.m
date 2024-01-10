function [Cl, Gkw]= fdct2(f, N, r0, mode, sf1, sf2)
%%% FDCT2 implements Two-dimensional Fast Discrete Circlelet Transform
%%% (FDCT). fdct2(f, N, r0 ,mode, sf1, sf2) returns the two-dimensional
%%% Circlelet transform and provides all the circlet coefficients related
%%% to scale k and radius r0.
%     Inputs:
%         f:  gray-level input image.
%         N:  the number of desire filters.
%         r0: radius range of candidate circles.
%         mode: has three values as
%                 'abs': returns the amplitude of CT coefficients
%                 'phase': returns the phase of CT coefficients
%                 'complex' returns the complex number of CT coefficients
%         sf1, sf2: pads f with zeros to create sf1-by-sf2 array befor
%                   doing the transform. The default is the dimension of f.
%     Outputs:
%         Cl: r-by-k cell data contains CT coefficients. r refers to the
%             number of radii defined in r0 and k refers to the number of
%             filters defined in N and describes the content of frequency.
%         Gkw: r-by-k cell data contains generated filters for computing
%              CT coefficients. These filters are used for inverse fdct2.
%
%  written by Omid Sarrafzadeh,
%  Isfahan University of Medical Sciences, Isfahan, Iran
%  Email: o.sarrafzade@gmail.com
%
% If you use the code provided here, please cite the following paper:
% O. Sarrafzadeh, A. Mehri, H. Rabbani, N. Ghane, A. Talebi, "Circlet based
% framework for red blood cells segmentation and counting", in Proc. IEEE
% Workshop on Signal Processing Systems,
% Hangzhou, China, Oct. 14-16, 2015.
%
%  Reference for CT:
%  H. Chauris, I. Karoui, P. Garreau, H. Wackernagel, P. Craneguy, and L.
%  Bertino, "The circlet transform: A robust tool for detecting features
%  with circular shapes," Computers & Geosciences, vol. 37, pp. 331-342,
%  2011.

    if nargin<=4
        [sf1,sf2] = size(f);
    end
    Cl = cell(length(r0),N);
    Gkw = cell(length(r0),N);
    for k=1:N
        for r=1:length(r0)
            Gkw{r,k} = Gk(r0(r), N, k, sf1, sf2);
        end
    end
    F = fft2(f,sf1,sf2);
    Fc = fftshift(F);
    switch mode
        case 'abs'
            for x=1:size(Gkw,1)
                for y=1:size(Gkw,2)
                    Cl{x,y} = abs(ifft2(Fc.*Gkw{x,y}));
                end
            end
        case 'phase'
            for x=1:size(Gkw,1)
                for y=1:size(Gkw,2)
                    Cl{x,y} = angle(ifft2(Fc.*Gkw{x,y}));
                end
            end
        case 'complex'
            for x=1:size(Gkw,1)
                for y=1:size(Gkw,2)
                    Cl{x,y} = ifft2(Fc.*Gkw{x,y});
                end
            end
    end
end

function Gkk = Gk(r0, N, k, sf1, sf2)
    w1_ = linspace(-pi,pi,sf1);
    w2_ = linspace(-pi,pi,sf2);
    w1 = repmat(w1_',1,sf2);
    w2 = repmat(w2_,sf1,1);
    absw = sqrt(w1.^2+w2.^2);
    Gkk = exp(1j.*absw.*r0).*Fk(absw,N,k);
end
% 
function F = Fk(w, N, k)
    Wk = pi*(k-1)/(N);
    [r, c] = size(w);
    w = w(:);
    d_n = abs(w-Wk);
    d_p = abs(w+Wk);
    F = zeros(length(w),1);
    dp = d_p <= (pi/(N));
    dn = d_n <= (pi/(N));
    F(dn) = cos(w(dn)-Wk);
    F(dp) = cos(w(dp)+Wk);
    F = reshape(F,r,c);
end
