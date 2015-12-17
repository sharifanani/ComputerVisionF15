close all
clear all
clc

cd TrainingImages;
folderList = dir;
cd ..
folderList(1:2) = [];
X=[];
for i = 1:size(folderList,1)
    if(folderList(i).isdir)
        dirStr= ['TrainingImages/',folderList(i).name,'/UnProcessed'];
    end
    fileNames = dir(dirStr);
    fileNames(1:2)=[];
    for j = 1:numel(fileNames)
        I = imread([dirStr,'/',fileNames(j).name]);
        X = [X,I(:)];
    end
end
b = struct2cell(folderList);
folderNames = b(1,:);
save ('imageXData.mat', 'folderNames','X')