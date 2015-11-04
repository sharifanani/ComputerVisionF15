close all
clear
clc
load('checkerData.mat')
load('imdata.mat')
squareSize=22.5;%in mm
worldPoints=generateCheckerboardPoints(boardSize, squareSize);
stereoParams=estimateCameraParameters(imagePoints, worldPoints);
save('stereoData.mat','stereoParams');