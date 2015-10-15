close all
clear cll
clc
load('imdata.mat');
numImages=length(imageFiles1);
showCheckers=1;
% imPoints1=cell(numImages,1);
% imPoints2=cell(numImages,1);
for i=1:length(imageFiles1)
    images1(:,:,:,i)=imageFiles1{i};
    images2(:,:,:,i)=imageFiles2{i};
    
end


[imagePoints, boardSize] = detectCheckerboardPoints(images1, images2);

if(showCheckers)
    figure
    for i=1:length(imageFiles1)
        subplot(1,2,1),subimage(images1(:,:,:,i));
        hold on
        plot(imagePoints(:,1,i,1),imagePoints(:,2,i,1));
        subplot(1,2,2),subimage(images2(:,:,:,i));
        hold on
        plot(imagePoints(:,1,i,2),imagePoints(:,2,i,2));
        
        pause()
        hold off
    end
    
end
save('checkerData.mat','imagePoints','boardSize')