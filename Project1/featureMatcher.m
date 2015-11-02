close all
clear all
clc

I=imread('cameraman.tif');

load('FEATURES1.mat');
FEATURES1=FEATURES;
squares1=squares;
load('FEATURES2.mat');
FEATURES2=FEATURES;
squares2 = squares;
clear FEATURES;
clear squares;
SIMILARITIES = cell(size(FEATURES1,2),size(FEATURES2,2));
NORMS = zeros(size(SIMILARITIES));
for i = 1 : size(FEATURES1,2)
   for j = 1:size(FEATURES2,2)
       SIMILARITIES{i,j} = conv(flip(FEATURES1{5,i}),FEATURES2{5,j});
       NORMS(i,j) = norm(SIMILARITIES{i,j});
   end
end

[val,ind] = min(NORMS(3,:));
figure;imshow(I,[]);hold on;plot(squares1{3}(1,:),squares1{3}(2,:))
figure;imshow(imrotate(I,45),[]);hold on;plot(squares2{ind}(1,:),squares2{ind}(2,:))

