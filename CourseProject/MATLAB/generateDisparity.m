close all
clear all
clc
load('imdata.mat');
load('stereoData.mat');
[J1,J2]=rectifyStereoImages(imageFiles1{1},imageFiles2{1},stereoParams);
disparityRange = [0, 64];
disparityMap = disparity(rgb2gray(J1), rgb2gray(J2), 'DisparityRange', ...
    disparityRange);
figure;
imshow(disparityMap, disparityRange, 'InitialMagnification', 50);
colormap('jet');
colorbar;
title('Disparity Map Before Histogram Equalization');

