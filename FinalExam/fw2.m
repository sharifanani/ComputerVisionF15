close all
clear all
clc
I = imread('B4.jpeg');
Igs = rgb2gray(I);
Ibw = Igs>130;
Ibw = imcomplement(Ibw);
Ibw = bwareaopen(Ibw,100);
Ibw = imcomplement(Ibw);
hblob = vision.BlobAnalysis;
hblob.MinimumBlobArea = 5;
hblob.MaximumCount=100;
[AREA,CENTROID,BBOX] = step(hblob,Ibw);
figure; imshow(I);hold on;
idxs = [];
for i = 1:size(AREA,1)
   if(AREA(i) > (size(Ibw,1)*size(Ibw,2))/20)
       idxs = [idxs,i];
   end
end
AREA(idxs)=[];
BBOX(idxs,:)=[];
CENTROID(idxs,:)=[];
for i = 1:size(BBOX,1)
rectangle('Position', BBOX(i,:),'EdgeColor','r', 'LineWidth', 1)
end
% % figure;imshow(Ibw)
% [L,num] = bwlabel(Ibw);
% % lumpProperties = regionprops(L,'Perimeter', 'Area', 'FilledArea', 'Solidity', 'Centroid');
% % Ifill = imfill(Ibw,'holes');
% boundaries = bwboundaries(Ibw);
% b = boundaries{1};
% figure;imshow(I);hold on;
% for i = 1:size(boundaries,1)
%     b = boundaries{i};
%     plot(b(:,2),b(:,1),'r','LineWidth',1.5);
% end

% perimeters = [lumpProperties.Perimeter];
% areas = [lumpProperties.Area];
% filledAreas = [lumpProperties.FilledArea];
% solidities = [lumpProperties.Solidity];