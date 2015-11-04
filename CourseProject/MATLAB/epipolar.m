close all;clear all;clc
load('stereoData');
load('imdata.mat');
im1=imageFiles1{1};im2=imageFiles2{1};
im1=rgb2gray(im1);im2=rgb2gray(im2);
F=stereoParams.FundamentalMatrix;
figure(1); 
subplot(1,2,1);subimage(im1);subplot(1,2,2);subimage(im2);
figure(1);title('Images Before Rectification')
[j1,j2]=rectifyStereoImages(im1,im2,stereoParams);
figure(2);
subplot(1,2,1);subimage(j1);subplot(1,2,2);subimage(j2);
figure(2);title('Images After Rectification, Before Histogram Equalization');
J1=histeq(j1);J2=histeq(j2);
figure(3);
subplot(1,2,1);subimage(J1);subplot(1,2,2);subimage(J2);
figure(3);title('Images After Histogram Equalization');


disparityRange = [0, 128];
disparityMap = disparity(j1, j2, 'DisparityRange', ...
    disparityRange);
figure(4);
imshow(disparityMap,disparityRange);
title('Disparity Map Before Histogram Normalization');



disparityMap2 = disparity(J1, J2, 'DisparityRange', ...
    disparityRange);
figure(5);
imshow(disparityMap,disparityRange)
title('Disparity Map After Histogram Normalization');
disparityDiff=disparityMap-disparityMap2;
figure(6);
imshow(disparityDiff,[]);
title('Difference Between Disparity Maps')
