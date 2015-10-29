close all
clear all
clc

scene = imread('autumn.tif');
scene = imgaussfilt(scene,1);
p=2+sqrt(2);
kernelx = [-1 0 1;
          2-p, 0 p-2;
          -1 0 1];
kernely = [-1, 2-p, -1;
            0, 0, 0;
            1, p-2, 1];
imResult1 = corrImages(kernelx, scene);
imResult2 = corrImages(kernely, scene);
figure(1)
subplot(221)
imshow(imResult1(:,:,1),[])
title('Horizontal Gradient')
% subplot(512)
% imshow(imResult2(:,:,1),[])
% title('Vertical Gradient')
subplot(222)
res_x = imResult1(:,:,1);
res_y = imResult2(:,:,1);
result = sqrt(res_x.^2 + res_y.^2);
imshow(result,[])
title('Magnitude of the gradient')
subplot(223)
J=threshImg(result);
imshow(J,[])
title('Edge Map')
subplot(224)
imshow(scene);
title('Original Image')