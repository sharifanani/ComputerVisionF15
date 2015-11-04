%% Correlation of images demo.
% This script demos thecorrImages.m function created to find a pattern in
% an image.
close all
clear all
clc

kernel = imread('WaldoKernel.png');scene = imread('WaldoScene.png');

imResult = corrImages(kernel,scene);
lChan = imResult(:,:,1);
[M,I]=max(lChan(:));
[row,col]=ind2sub(size(lChan),I);
width = 20;
height = 40;
sizeDiff = size(kernel);
center = [row,col]+sizeDiff(1:2)/2;
circCorners = int32([center(2),center(1),40]);
shapeInserter = vision.ShapeInserter('Shape','Circles','LineWidth',4);
J=step(shapeInserter,scene,circCorners);
imshow(J);
