%%%%%%%%%% plot the basis functions of circlet & Ellipselet
%  written by Zahra Khodabandeh,
%  Isfahan University of Medical Sciences, Isfahan, Iran
%  Email: shimakhodabandeh@yahoo.com
clear all;close all;clc
A = 10;
B = 1;
D = 1;
e = double(Ellipse(50,20,45,250,250,512,512));
c = ~Circle(50,128,128,256,256);
figure,title('Circle & Ellipse with their Fourier Transforms')
    subplot 221,imshow(c);colormap jet;colorbar
    subplot 222,imshow(e);colormap jet;colorbar
C = fft2(c);
Cc = fftshift(C);
E = fft2(e);
Ec = fftshift(E);
    subplot 223,imshow(log(1+abs(Cc)),[]);colormap jet;colorbar
    subplot 224,imshow(log(1+abs(Ec)),[]);colormap jet;colorbar

[Clc,Gkc]= fdc(c, 4, 50, 'complex');
figure,
for k=1:4
    subplot (2,2,k),imshow(abs(Gkc{k}));colormap jet;colorbar
end
figure,
for k=1:4
    subplot (2,2,k),imshow(angle(Gkc{k}));colormap jet;colorbar
end

[Cle,Gke]= fde1(e, 4, 50, 20, 'complex');
figure,
for k=1:4
    subplot (2,2,k),imshow(abs(Gke{k}));colormap jet;colorbar
end
figure,
for k=1:4
    subplot (2,2,k),imshow(angle(Gke{k}));colormap jet;colorbar
end

[Cle,Gke]= fde2(e, 4, 50, 20, 'complex');
figure,
for k=1:4
    subplot (2,2,k),imshow(abs(Gke{k}));colormap jet;colorbar
end
figure,
for k=1:4
    subplot (2,2,k),imshow(angle(Gke{k}));colormap jet;colorbar
end
[Cle,Gke]= fde3(e, 4, 50, 20, 'complex');
figure,
for k=1:4
    subplot (2,2,k),imshow(abs(Gke{k}));colormap jet;colorbar
end
figure,
for k=1:4
    subplot (2,2,k),imshow(angle(Gke{k}));colormap jet;colorbar
end
[Cle,Gke]= fde4(e, 4, 50, 20, 'complex');
figure,
for k=1:4
    subplot (2,2,k),imshow(abs(Gke{k}));colormap jet;colorbar
end
figure,
for k=1:4
    subplot (2,2,k),imshow(angle(Gke{k}));colormap jet;colorbar
end

