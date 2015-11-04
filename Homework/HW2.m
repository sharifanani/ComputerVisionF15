%% Computer Vision -- Fall 2015
%% Homework 2 - Rank K Approximation - Sharif Anani

close all
clear all
clc

%% Problem Statement:
% In class we discussed using the singular value decomposition for
% computing best rank k approximations.
% In this assignment you will apply such techniques to illustrate
% the level of “compression” seen when different
% rank k approximations on images

img = imread('house.jpg');
img = rgb2gray(img);
img = double(img);
[U,S,V] = svd(img);
%% Using the SVD of the image to re-build is using smaller rank matrices
%%
% For purposes of illustration, we first display our "uncompressed" image
i=1;
figure(i)
imshow(img,[]);
title('Image without using rank K approximation');
%%
% The next series of figures illustrates images reconstructed from K
% singular values as indicated in the title of each image.
for k=5:5:60
    i=i+1;
    figure(i)
    img2 = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
    imshow(img2,[]);
    str= sprintf('Image reconstructed from the first %i singular values',k);
    title(str);
end
