function [ manifold,eigBasis ] = getManifold( dataSetName , mu , unBias , k )
%GETEIGENSPACE Summary of this function goes here
%   Detailed explanation goes here
if(mu ~= 0)
%     fprintf('Calculating with optimal k using mu value\n')
    useMu = 1;
elseif(mu==0)
%     fprintf('Calculating using the specified number of eigenvectors (k)\n')
    useMu = 0;
end


load(dataSetName);
if(~isfloat(X))
    X = double(X);
end
[U,S,V] = svd(X,0);
clear S
clear V
% if(useMu)
%    k2 = ComputeER(X,U,mu); 
% else
%     k2 = k;
% end
m = mean(X,2);
if(unBias)
   for i = 1:size(X,2)
      X(:,i) = X(:,i)-m ;
   end
end
if(useMu)
   [k2,y] = ComputeER(X,U,mu); 
   clear y
else
    k2 = k;
end
k2;
eigBasis = U(:,1:k2);
manifold = zeros(size(X,2),k2);
for i = 1:size(X,2)
    point =[];
    vect = X(:,i)';
    for j = 1:size(eigBasis,2)
        point = [point,vect*eigBasis(:,j)];
    end
    manifold(i,:)=point;
end

end

