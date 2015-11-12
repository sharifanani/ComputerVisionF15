close all
clear
clc
I1 = imread('P1Images/wall/img1.ppm');
I2 = imread('P1Images/wall/img6.ppm');
detectMatchFeatures(I1,I2,0.4)