close all
clear all
clc
I = imread('cameraman.tif');
[rows,cols] = cornerDetection(I);
SQUARES = cell(size(cols));
for i = 1:length(cols)
   SQUARES{i} = getSquare(10, pi/4, cols(i),rows(i));
end

figure;imshow(I);hold on;

for i = 1:length(SQUARES)
    buff = SQUARES{i};
   plot(buff(1,:),buff(2,:),'r');
end