%%%% This function makes basis of Ellipelet with 0 degree
function [Cl,Gkw]= fde(f, N, a, b, mode, sf1, sf2)
%     Inputs:
%         f:  gray-level input image.
%         N:  the number of filters.
%         a = major axis, b = minor axis
%         mode: has three values as
%                 'abs': returns the amplitude of CT coefficients
%                 'phase': returns the phase of CT coefficients
%                 'complex' returns the complex number of CT coefficients
%         sf1, sf2: pads f with zeros to create sf1-by-sf2 array befor
%                   doing the transform. The default is the dimension of f.
%
%  written by Zahra Khodabandeh,
%  Isfahan University of Medical Sciences, Isfahan, Iran
%  Email: shimakhodabandeh@yahoo.com
%
% If you use the code provided here, please cite the following paper:
% Khodabandeh Z, Rabbani H, Dehnavi AM, Sarrafzadeh O. The ellipselet transform. J Med Sign Sens 2019;9:145-57.


    if nargin<=5
        [sf1,sf2] = size(f);
    end
    Cl = cell(length(a),N);
    Gkw = cell(length(a),N);
    for k=1:N
        for r=1:length(a)
            Gkw{r,k} = Gk(a, b, N, k, sf1, sf2);
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
function Gkk = Gk(a, b, N, k, sf1, sf2)
    w1_ = linspace(-pi,pi,sf1);
    w2_ = linspace(-pi,pi,sf2);
    w1 = repmat(w1_',1,sf2);
    w2 = repmat(w2_,sf1,1);
    absw = sqrt(10.*w1.^2+w2.^2-w1.*w2);
%     absw = sqrt(A.*w1.^2+B.*w2.^2-D.*w1.*w2);
    Gkk = exp(1j.*absw*a).*Fk_final(absw,N,k);
end
