function [k,y] = ComputeER (X,eigenMat,mu)
%ComputeER: function to calculate the number of eigenvectors needed to
%recover a certain amount of energy
%input X: Matrix of elongated images ( Ij(:) ), where Ij is the jth
%training image
%input eigenMat: The left singular matrix after SVD, which correspond to
%the eigenvectors of the sample covariance matrix
%input mu: the desired percentage of energy recovered (0<mu<=1)
N = norm(X,'fro')^2;
n=0;
y=[];
for i = 1:size(eigenMat,2)
    n = n+((norm(eigenMat(:,i)' * X, 'fro'))^2)/N;
    y = [y,n];
    if(n>=mu)
        break
    end
end
% plot(1:numel(y),y);
k=i;
end