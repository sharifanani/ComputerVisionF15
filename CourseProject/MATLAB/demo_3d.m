close all
clear all
clc
load('stereoData.mat')

cam1=webcam(1);
cam2=webcam(3);
preview(cam1);
preview(cam2);

pause();
pause(5);
image1=snapshot(cam1);
image2=snapshot(cam2);
[J2,J1]=rectifyStereoImages(image1,image2,stereoParams);
figure(1)
imshow(stereoAnaglyph(J1,J2))
figure(2);
imshow(stereoAnaglyph(image1,image2));
disparityRange = [0,64];
disparityMap = disparity(rgb2gray(J1), rgb2gray(J2),'DisparityRange',disparityRange);
figure(3);
imshow(disparityMap);
colormap('jet');
colorbar;
title('Disparity Map');
clear cam1
clear cam2