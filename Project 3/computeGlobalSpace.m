%% Computing the global eigenspace to save to disk
close all
clear all
clc
%% Reading the input mat file containing all eigenspaces for all the sets
load('trainingData.mat');%organized as Name|Manifold|Eigenspace
%% Extracting the cell array of eigenbasis vectors
eigs = trainingData(:,3);
eigs2=eigs';
fullEig = cell2mat(eigs2);
[U,S,V] = svd(fullEig,'econ');
clear S
clear V
k = ComputeER(fullEig,U,0.9);
fprintf('The number needed for a good representation here is:%4.0i\n',k)
%% Calculating the eigenspace by using all images at once first
load('imageXData.mat');
clear U
X=double(X);
[U2,S,V] = svd(X,'econ');
clear S
clear V
k2 = ComputeER(X,U2,0.9);
fprintf('The number needed for a good representation here is:%4.0i\n',k2)
%% Computing the manifolds
manifold1 = zeros(size(fullEig,2),k);
point = [];
eBasis = U(:,1:k);
for i = 1:size(fullEig,2)
    vect = fullEig(:,i)';
    for j = 1:size(eBasis,2)
       point=[point,vect*eBasis(:,j)]; 
    end
    manifold1(i,:)=point;
    point = [];
end
manifold2 = zeros(size(X,2),k2);
point = [];
eBasis2 = U2(:,1:k2);
for i=1:size(X,2)
    vect = X(:,i)';
    for j = 1:size(eBasis2,2)
        point = [point,vect*eBasis2(:,j)];
    end
    manifold2(i,:)=point;
    point =[];
end