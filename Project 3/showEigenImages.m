close all
clear all
clc
setName = 'imageXData.mat';
dirList = dir;
mu = [0.9];
unBias = 1;
k = 7;%only used if mu==0
kToRecovery = cell(20,2);
trainingData = cell(20,3);
cellIdx=1;
%calculate all manifolds and spaces
for i = 1:size(dirList,1)
    if(~dirList(i).isdir)
        if(strcmp(dirList(i).name(end-3:end),'.mat'))
            setName = dirList(i).name;
            p=[];
            [man,eigBasis] = getManifold(setName,mu,unBias,k);
            trainingData(cellIdx,1)={setName};
            trainingData(cellIdx,2)={man};
            trainingData(cellIdx,3)={eigBasis};
            cellIdx = cellIdx+1;
            fprintf('.');
        end
    end
end
fprintf('\n');
X = man(:,1); Y=man(:,2); Z = man(:,3);
titlestr = ['Seven eigenimages for the set ',setName, '(All training images in all sets)'];
figure;
eigenImages = [];
for i=1:7
   eigenImages = [eigenImages, reshape(eigBasis(:,i),[],128)];
end
imshow(eigenImages,[])
% % plot3(X,Y,Z,'.');
title(titlestr);
% % grid on

