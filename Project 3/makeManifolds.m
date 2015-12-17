%% Script to generate manifolds for detecting the orientation of the object
close all
clear all
clc
dirName = 'imageData';
targetDirNameManifolds = 'MANIFOLDS';
targetDirNameSpaces = 'SPACES';
targetDirNameMeans = 'MEANS';
dirList = dir(dirName);
dirList(1:2) = []; %the first two are to go back directories
for i = 1:size(dirList,1)
   [man,eBasis] = getManifold([dirName,'/',dirList(i).name],0.9,1,0);
   save([targetDirNameManifolds,'/',dirList(i).name],'man');
   save([targetDirNameSpaces,'/',dirList(i).name],'eBasis');
   load([dirName,'/',dirList(i).name])
   m = mean(X,2);
   save([targetDirNameMeans,'/',dirList(i).name],'m')
   fprintf('.');
end
fprintf('\n');