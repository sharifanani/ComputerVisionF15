close all
clear all
clc
p1 = [ones(5,10);zeros(5,10)]
G = fspecial('gaussian',3,1);
p2 = p1'
[Gx, Gy]=gradient(G);
p1x = conv2(p1,Gx,'same');
p1y = conv2(p1,Gy,'same');
p2x = conv2(p2,Gx,'same');
p2y = conv2(p2,Gy,'same');
p1xm = mean(p1x(:));
p1ym = mean(p1y(:));
angle1 = atan2(p1ym,p1xm)*180/pi
p2xm = mean(p2x(:));
p2ym = mean(p2y(:));
angle2 = atan2(p2ym,p2xm)*180/pi
