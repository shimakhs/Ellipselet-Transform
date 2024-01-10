function f = Ellipse_denoising(f,N,a1,b1,Sigma,method)
%% apply FDE
f = double(f);
[Cle1,Gke1]= fde1(f, N, a1, b1, 'complex');
[Cle2,Gke2]= fde2(f, N, a1, b1, 'complex');
[Cle3,Gke3]= fde3(f, N, a1, b1, 'complex');
[Cle4,Gke4]= fde4(f, N, a1, b1, 'complex');
%% calculate threshold for each subband
Nsig = Sigma;
%% Modify coefficients1
method = 's';
c = [1,3,4];
for x=1:size(Cle1,1)
    for y=1:3

        rel1{x,c(y)}(:,:) = (real(Cle1{x,c(y)}(:,:)));
        img1{x,c(y)}(:,:) = (imag(Cle1{x,c(y)}(:,:)));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
for x=1:size(Cle1,1)
    for y=1:3
        
        Ssig_rel1(x,c(y)) = sqrt( max((std2(rel1{x,c(y)})^2-Nsig^2),eps));
        Thresh_rel1(x,c(y)) = (Nsig^2)/Ssig_rel1(x,c(y));
        Ssig_img1(x,c(y)) = sqrt( max((std2(img1{x,c(y)})^2-Nsig^2),eps));
        Thresh_img1(x,c(y)) = (Nsig^2)/Ssig_img1(x,c(y));
        
        Cln11{x,c(y)} = wthresh(rel1{x,c(y)},method,Thresh_rel1(x,c(y)));
        Cln21{x,c(y)} = wthresh(img1{x,c(y)},method,Thresh_img1(x,c(y)));
Cln1{x,c(y)}=Cln11{x,c(y)}+ sqrt(-1)*Cln21{x,c(y)};
    end
end
     for x=1:size(Cle1,1)
         Cln1{x,2} = Cle1{x,2};
     end
%%% Inverse of FCT
f1 = abs(ifde(Cln1, Gke1));

%% Modify coefficients2
method = 's';  
for x=1:size(Cle2,1)
    for y=1:3
        rel2{x,c(y)}(:,:) = (real(Cle2{x,c(y)}(:,:)));
        img2{x,c(y)}(:,:) = (imag(Cle2{x,c(y)}(:,:)));


    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
for x=1:size(Cle2,1)
    for y=1:3
        
        Ssig_rel2(x,c(y)) = sqrt( max((std2(rel2{x,c(y)})^2-Nsig^2),eps));
        Thresh_rel2(x,c(y)) = (Nsig^2)/Ssig_rel2(x,c(y));
        Ssig_img2(x,c(y)) = sqrt( max((std2(img2{x,c(y)})^2-Nsig^2),eps));
        Thresh_img2(x,c(y)) = (Nsig^2)/Ssig_img2(x,c(y));
        
        Cln12{x,c(y)} = wthresh(rel2{x,c(y)},method,Thresh_rel2(x,c(y)));
        Cln22{x,c(y)} = wthresh(img2{x,c(y)},method,Thresh_img2(x,c(y)));
Cln2{x,c(y)}=Cln12{x,c(y)}+ sqrt(-1)*Cln22{x,c(y)};
    end
end
     for x=1:size(Cle2,1)
         Cln2{x,2} = Cle2{x,2};
     end
% %% Inverse of FCT
f2 = abs(ifde(Cln2, Gke2));
%% Modify coefficients3
method = 's';  
for x=1:size(Cle3,1)
    for y=1:3
        rel3{x,c(y)}(:,:) = (real(Cle3{x,c(y)}(:,:)));
        img3{x,c(y)}(:,:) = (imag(Cle3{x,c(y)}(:,:)));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
for x=1:size(Cle3,1)
    for y=1:3
        
        Ssig_rel3(x,c(y)) = sqrt( max((std2(rel3{x,c(y)})^2-Nsig^2),eps));
        Thresh_rel3(x,c(y)) = (Nsig^2)/Ssig_rel3(x,c(y));
        Ssig_img3(x,c(y)) = sqrt( max((std2(img3{x,c(y)})^2-Nsig^2),eps));
        Thresh_img3(x,c(y)) = (Nsig^2)/Ssig_img3(x,c(y));
        
        Cln13{x,c(y)} = wthresh(rel3{x,c(y)},method,Thresh_rel3(x,c(y)));
        Cln23{x,c(y)} = wthresh(img3{x,c(y)},method,Thresh_img3(x,c(y)));
Cln3{x,c(y)}=Cln13{x,c(y)}+ sqrt(-1)*Cln23{x,c(y)};
    end
end
  for x=1:size(Cle3,1)
         Cln3{x,2} = Cle3{x,2};
   end
% %% Inverse of FCT
f3 = abs(ifde(Cln3, Gke3));
%% Modify coefficients4
method = 's';  
for x=1:size(Cle4,1)
    for y=1:3
        rel4{x,c(y)}(:,:) = (real(Cle4{x,c(y)}(:,:)));
        img4{x,c(y)}(:,:) = (imag(Cle4{x,c(y)}(:,:)));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
for x=1:size(Cle4,1)
    for y=1:3
        
        Ssig_rel4(x,c(y)) = sqrt( max((std2(rel4{x,c(y)})^2-Nsig^2),eps));
        Thresh_rel4(x,c(y)) = (Nsig^2)/Ssig_rel4(x,c(y));
        Ssig_img4(x,c(y)) = sqrt( max((std2(img4{x,c(y)})^2-Nsig^2),eps));
        Thresh_img4(x,c(y)) = (Nsig^2)/Ssig_img4(x,c(y));
        
        Cln14{x,c(y)} = wthresh(rel4{x,c(y)},method,Thresh_rel4(x,c(y)));
        Cln24{x,c(y)} = wthresh(img4{x,c(y)},method,Thresh_img4(x,c(y)));
Cln4{x,c(y)}=Cln14{x,c(y)}+ sqrt(-1)*Cln24{x,c(y)};
    end
end
        
     for x=1:size(Cle4,1)
         Cln4{x,2} = Cle4{x,2};
     end
%      
% %% Inverse of FDE
f4 = abs(ifde(Cln4, Gke4));
f = f1+f2+f3+f4;