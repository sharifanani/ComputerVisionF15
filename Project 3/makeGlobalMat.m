%% Script to create the global matrix X
close all
clear all
clc
X2= [];
dirName = 'imageData';
targetDirNameManifolds = 'GLOBALMANIFOLD';
targetDirNameSpaces = 'GLOBALSPACE';
targetDirNameMeans = 'GLOBALMEAN';
targetDirXData = 'GLOBALDATA';
dirList = dir(dirName);
dirList(1:2) = []; %the first two are to go back directories
for i = 1:size(dirList,1)
    load([dirName,'/',dirList(i).name]);
    X2=[X2,X];
end
X=X2;
clear X2;
m = mean(X,2);
for i = 1:size(X,2)
   X(:,i) = X(:,i) - m; 
end
save([targetDirXData,'/GlobalData.mat'],'X');
[man,eBasis] = getManifold('GLOBALDATA/GlobalData.mat',0.9,1,1);
save([targetDirNameMeans,'/GlobalData.mat'],'m');
save([targetDirNameSpaces,'/GlobalData.mat'],'eBasis');
save([targetDirNameManifolds,'/GlobalData.mat'],'man');

% 
% for i = 1:size(dirList,1)
%    [man,eBasis] = getManifold([dirName,'/',dirList(i).name],0.9,1,0);
%    save([targetDirNameManifolds,'/',dirList(i).name],'man');
%    save([targetDirNameSpaces,'/',dirList(i).name],'eBasis');
%    load([dirName,'/',dirList(i).name])
%    m = mean(X,2);
%    save([targetDirNameMeans,'/',dirList(i).name],'m')
%    fprintf('.');
% end
% fprintf('\n');