close all
clear all
clc
I = imread('B2.jpeg');
Igs = rgb2gray(I);
Ibw = Igs>130;
Ibw = imcomplement(Ibw);
Ibw = bwareaopen(Ibw,250);
Ibw = double(Ibw);
Ibw = imgaussfilt(Ibw,1);
Ibw2 = edge(Igs,'canny');
se = strel('rectangle',[1,1]);
Ibw2 = imerode(Ibw2,se);
Iedge = (Ibw2==1);
for i = 1:size(Ibw2,1)
    for j = 1:size(Ibw2,2)
        if(Ibw2(i,j)==1)
           I(i,j,1)=255;
           I(i,j,2)=0;
           I(i,j,3)=0;
        end
    end
end
Iedge = Iedge*255;
IedgeC = zeros(size(I));
IedgeC(:,:,1)=Iedge;
C=corner(Ibw);
imshow(I);hold on;
plot(C(:,1),C(:,2),'*r');
figure;
imshow(I,[])