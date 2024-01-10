%%% Here, it is assumed that the exact
%%% radius and number of the desire ellipses are known and we just need to
%%% find the location of the ellipses and angle of them.
%  written by Zahra Khodabandeh,
%  Isfahan University of Medical Sciences, Isfahan, Iran
%  Email: shimakhodabandeh@yahoo.com
%
% If you use the code provided here, please cite the following paper:
% Khodabandeh Z, Rabbani H, Dehnavi AM, Sarrafzadeh O. The ellipselet transform. J Med Sign Sens 2019;9:145-57.

clear all; close all; clc;
%% read the image
I = imread('E5.JPG');
f = rgb2gray(I);
f = im2double(f);
figure; imshow(f);
%% apply the Ellipselet transform
basis = cell(1,4);
N = 4;                      % number of filters
a1 = 50;
b1 = 20;
% [Cle,Gke]= fde(f, 4, a, b, 'abs');
[Cle1,Gke1]= fde1(f, 4, a1, b1, 'abs');
[Cle2,Gke2]= fde2(f, 4, a1, b1, 'abs');
[Cle3,Gke3]= fde3(f, 4, a1, b1, 'abs');
[Cle4,Gke4]= fde4(f, 4, a1, b1, 'abs');
basis{1,1}{1,1} =Cle1; 
basis{1,1}{1,2} =Gke1; 
basis{1,2}{1,1} =Cle2; 
basis{1,2}{1,2} =Gke2; 
basis{1,3}{1,1} =Cle3;
basis{1,3}{1,2} =Gke3;
basis{1,4}{1,1} =Cle4;
basis{1,4}{1,2} =Gke4;
%% draw all subbands
figure;
k5 = 1;
for i = 1: size(basis,1)
    for j = 1:size(basis,2)
            k = 1;
        for i1 = 1:size(Cle1,1)
            for j1 = 1:size(Cle1,2)
%% on binary of subbands
    nn{i,j}{1,1}{i1,j1} =((basis{i,j}{1,1}{i1,j1})-min(basis{i,j}{1,1}{i1,j1}(:)))/(max(basis{i,j}{1,1}{i1,j1}(:))-min(basis{i,j}{1,1}{i1,j1}(:)));
    mm{i,j}{1,1}{i1,j1}= im2bw(nn{i,j}{1,1}{i1,j1},0.2);
    se = strel('disk',25);
    kk{i,j}{1,1}{i1,j1}= imclose(mm{i,j}{1,1}{i1,j1},se); 
    subplot(4,4,k5);imshow(kk{i,j}{1,1}{i1,j1});
    k = k+1;
    k5 = k5+1;
    end
        end
    end
end
figure;
g = 1;
for t= 1:4
    R1{1,t} = radon(kk{1,1}{1,1}{1,t},90);
    med1{1,t} = medfilt1(R1{1,t});
    subplot(1,4,g);plot(med1{1,t});
    pks1{1,t} = findpeaks(med1{1,t});
    maxxx1{1,t} = max(med1{1,t});
    Th1{1,t} = 0.65*(max(pks1{1,t}));
    A1{1,t} = med1{1,t} >=Th1{1,t};
    MM1{1,t} = find(A1{1,t} == 1);
if (med1{1,t}(min(MM1{1,t}):max(MM1{1,t})) >= Th1{1,t}) 
    Theta1{1,t} = 90;
else
    Theta1{1,t} = {'-'};
end
g = g+1;
end
figure;
g = 1;
for t= 1:4
    R2{1,t} = radon(kk{1,2}{1,1}{1,t},0);
        med2{1,t} = medfilt1(R2{1,t});
    subplot(1,4,g);plot(med2{1,t});
        pks2{1,t} = findpeaks(med2{1,t});
        maxxx2{1,t} = max(med2{1,t});
        Th2{1,t} = 0.65*(max(pks2{1,t}));
    A2{1,t} = med2{1,t} >=Th2{1,t};
    MM2{1,t} = find(A2{1,t} == 1);
if (med2{1,t}(min(MM2{1,t}):max(MM2{1,t})) >= Th2{1,t}) 
    Theta2{1,t} = 0;
else
    Theta2{1,t} = {'-'};
end
g = g+1;
end
figure;
g = 1;
for t= 1:4
    R3{1,t} = radon(kk{1,3}{1,1}{1,t},+45);
        med3{1,t} = medfilt1(R3{1,t});
    subplot(1,4,g);plot(med3{1,t});
        pks3{1,t} = findpeaks(med3{1,t});
        maxxx3{1,t} = max(med3{1,t});
        Th3{1,t} = 0.65*(max(pks3{1,t}));
    A3{1,t} = med3{1,t} >=Th3{1,t};
    MM3{1,t} = find(A3{1,t} == 1);
if (med3{1,t}(min(MM3{1,t}):max(MM3{1,t})) >= Th3{1,t}) 
    Theta3{1,t} = 45;
else
    Theta3{1,t} = {'-'};
end
g = g+1;
end
figure;
g = 1;
for t= 1:4
    R4{1,t} = radon(kk{1,4}{1,1}{1,t},-45);
        med4{1,t} = medfilt1(R4{1,t});
    subplot(1,4,g);plot(med4{1,t});
        pks4{1,t} = findpeaks(med4{1,t});
        maxxx4{1,t} = max(med4{1,t})
                Th4{1,t} = 0.65*(max(pks4{1,t}));
    A4{1,t} = med4{1,t} >=Th4{1,t};
    MM4{1,t} = find(A4{1,t} == 1);
if (med4{1,t}(min(MM4{1,t}):max(MM4{1,t})) >= Th4{1,t}) 
    Theta4{1,t} = -45;
else
    Theta4{1,t} = {'-'};
end
g = g+1;
end

%% find two peaks of cofficients to find center of ellipse
AA = cell2mat(basis{1,4}{1,1}(1,1)); % it is for -45 basis and for other degrees the basis should be changed
figure; plot(AA);
Th = 0.8*(max(max(AA)));
[rowCle,ColCle] = find(AA >= Th);
meanRow = mean(rowCle);
[row1,col1] = find(rowCle <= meanRow);
[row2,col2] = find(rowCle >= meanRow);
max1=0;
for i = 1:size(row1,1)
    a1=AA(rowCle(row1(i),col1(i)),ColCle(row1(i),col1(i)));
    if a1>=max1
        max1=a1;
    end
end
[m1final,n1final]=find(AA == max1);
max2=0;
for i = 1:size(row2,1)
    a2=AA(rowCle(row2(i),col2(i)),ColCle(row2(i),col2(i)));
    if a2>=max2
        max2=a2;
    end
end
[m2final,n2final]=find(AA == max2);
x = mean([m2final, m1final]);
y = mean([n1final , n2final]);
%  Center of ellipse
pts = [x , y];
% direction of ellipse
Theta = [Theta1;Theta2;Theta3;Theta4];
%% find dimension of Ellpise with projection of image
R1 =  radon(f,cell2mat(Theta4(1,1)));  % Theta should be changed related to the degree
R2 = radon(f,cell2mat(Theta4(1,1))+90);  % Theta should be changed related to the degree
X1 = find(R1 ~= 0);
big = (max(X1) - min(X1))/2; % big dimension
X2 = find(R2 ~= 0);
small = (max(X2) - min(X2))/2; % small dimension
%%%
Detected_Ellipse = Ellipse(50,20,cell2mat(Theta4(1,1)),x,y,512,512); % Theta should be changed related to the degree
figure;imshow(f);hold on ; contour(Detected_Ellipse,'r')