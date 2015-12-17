close all
clear all
clc
I = imread('B2.jpeg');
I = rgb2gray(I);
% I=imresize(I,2);
BW = edge(I,'canny');
BW=double(BW);
BW = imgaussfilt(BW,1);
figure;
BW=imrotate(BW,90)
imshow(BW)
numpeaks = 100;
[H, theta, rho] = hough(BW);
peaks = houghpeaks(H, numpeaks);
lines = houghlines(BW, theta, rho, peaks,'MinLength',7,'FillGap',1);
figure(2);imshow(I,[]);
hold on;
idxs=[];
for i = 1:numel(lines)
   if abs(lines(i).rho)>55
       idxs=[idxs,i];
   end
end
lines(idxs)=[];
xy=[lines(150).point1;lines(150).point2];
plot(xy(:,1),xy(:,2));
% p1 = cat(1,lines.point1);
% p2 = cat(1,lines.point2);
% p1x = p1(:,1); p1y = p1(:,2);
% p2x = p2(:,1); p2y = p2(:,2);
% plot([p1x(1),p2x(1)],[p1y(1),p2y(1)])