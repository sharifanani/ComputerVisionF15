%% Script to locally matcha test image and guess its orientation
function [matchIndex] = matchLocal (setName,testImageNumd,origSetName)
% setName = 'Boat';
setName = setName(numel('Imagedata')+1:end-6);
testSetDirName = ['TestImages/',setName,'32/UnProcessed'];
testImageNum = num2str(testImageNumd); %which test image to test;
testSetImageName = [testSetDirName,'/','img_',testImageNum,'.png'];
manifoldName = ['MANIFOLDS/','Imagedata',setName,'64.mat'];
spaceName = ['SPACES/','Imagedata',setName,'64.mat'];
meanName =['MEANS/','Imagedata',setName,'64.mat'];
IrefString=['TrainingImages/',origSetName,'64/UnProcessed/img_'];
%% Loading the information from the set
load(manifoldName);
load(spaceName);
load(meanName);
I = double(imread(testSetImageName));
I=I(:);
point = [];
vect = I';
for i = 1:size(eBasis,2)
    point = [point, vect*eBasis(:,i)];
end
%% Computing the SSD
SSDs = [];
for i = 1:size(man,1)
    SSDs =[SSDs,sum(abs((point-man(i,:))))];
end
[val,ind] = min(SSDs);
IrefString=[IrefString,num2str(ind+1),'.png'];
Iref = double(imread(IrefString));
Isbs = [Iref,reshape(I,[],128)];
imshow(Isbs,[])
matchIndex = ind;
end