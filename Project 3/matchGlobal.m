%% Script to match globally to relate an image to a set of training images
function [setName] = matchGlobal(testSetName,testImageNum)
setNameLists = dir('imageData');
setNameLists(1:2)=[];
dirNameMean = 'GLOBALMEAN/';
dirNameSpace = 'GLOBALSPACE/';
dirNameManifold = 'GLOBALMANIFOLD/';
dirNameData = 'GLOBALDATA/';
dataName = 'GlobalData.mat';
% testSetName = 'imac04';
dirNameTestSet = ['TestImages/',testSetName,'32/UnProcessed/'];
% testImageNum = 45;
testImagePath = [dirNameTestSet,'img_',num2str(testImageNum),'.png'];
Itest = double(imread(testImagePath));
load([dirNameManifold,dataName]);
load([dirNameSpace,dataName]);
load([dirNameMean,dataName]);
Itest = Itest(:) -m;
vect = Itest';
load([dirNameManifold,dataName]);
load([dirNameSpace,dataName]);
point = [];
for i = 1:size(eBasis,2)
   point = [point,vect*eBasis(:,i)]; 
end
SSDs = [];
for i = 1:size(man,1)
   SSDs =[SSDs,sum(abs((point-man(i,:))))];
end
[val,ind] = min(SSDs);
setNum = floor(ind/128)+1;
setName = setNameLists(setNum).name;
end