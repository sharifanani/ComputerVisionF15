close all
clear all
clc

setName = 'Boat64';
testDir = '/home/sharif/ComputerVisionF15/Project 3/TestImages/Boat32/UnProcessed';
load('imageXData.mat');
k = 3;
for i = 1:numel(folderNames)
    if(strcmp(setName,folderNames{i}))
        break
    end
end
startIdx = 1+((i-1)*128);
endIdx = startIdx+127;
Xp = X(:,startIdx:endIdx);
% load('ImagedataBoat64.mat')
% Xp = X;
clear X
Xp = double(Xp);
m=mean(Xp,2);
for(i = 1:size(Xp,2))
   Xp(:,i) = Xp(:,i)-m; 
end


[U,S,V] = svd(Xp,0);

imStr = [testDir, '/img_11.png'];
testImage = imread(imStr);

eigBasis = U(:,1:k);
subSpace = zeros(size(Xp,2),3);
for i = 1:size(Xp,2)
    point =[];
    vect = Xp(:,i)';
    for j = 1:size(eigBasis,2)
        point = [point,vect*eigBasis(:,j)];
    end
    subSpace(i,:)=point;
end
if(k==3)
    X = subSpace(:,1); Y = subSpace(:,2);Z=subSpace(:,3);
    figure;plot3(X,Y,Z,'o');
    hold on
    testImage = double(testImage);
    testImage = testImage(:) -m;
    testImage = testImage';
    tPoint = [testImage*eigBasis(:,1),testImage*eigBasis(:,2),testImage*eigBasis(:,3)];
    plot3(tPoint(1),tPoint(2),tPoint(3),'or')
end
