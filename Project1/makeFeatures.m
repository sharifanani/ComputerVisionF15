close all
clear all
clc

I = imread('cameraman.tif');
I = imrotate(I,45);
[rows,cols] = cornerDetection(I);
I = double(I);
G = fspecial('gaussian',3,1);
[Gx,Gy] = gradient(G);
Hx = conv2(I,Gx,'same');
Hy = conv2(I,Gy,'same');
H = Hx+Hy;
gradAtPoints1 = zeros(1,length(rows));
gradAtPoints2 = zeros(2,length(rows));
angles = gradAtPoints1;
%% get the gradient at all corner points
for i = 1:length(rows)
    gradAtPoints1(i) = H(rows(i),cols(i));
    gradAtPoints2(1,i) = Hx(rows(i),cols(i));
    gradAtPoints2(2,i) = Hy(rows(i),cols(i));
    angles(i) = atan(gradAtPoints2(2,i)/gradAtPoints2(1,i));
end
%% get the square points
ind1 = [];
for i = 1:length(rows)
   if((rows(i) > size(I,2)-5) || rows(i)<5)
       ind1 = [ind1,i];
   end
end
rows(ind1) = [];
cols(ind1) = [];

ind1 = [];
for i = 1:length(cols)
   if((cols(i) < 5) || cols(i) > size(I,1)-5)
       ind1 = [ind1,i];
   end
end
rows(ind1) = [];
cols(ind1) = [];

squares = cell(size(rows));
for i = 1:length(squares)
   squares{i} = getSquare(10,angles(i),cols(i),rows(i)); 
end
%% composing our cell array of features
FEATURES = cell(5,length(rows));
for i = 1:length(rows)
    FEATURES{1,i} = [rows(i),cols(i)];
    FEATURES{2,i} = [Hx(rows(i),cols(i)),Hy(rows(i),cols(i))];
    FEATURES{3,i} = I(rows(i)-1:rows(i)+1,cols(i)-1:cols(i)+1);    
    FEATURES{4,i} = imrotate(FEATURES{3,i},-1*atan(FEATURES{2,i}(2)/FEATURES{2,i}(1))*180/pi);
    FEATURES{5,i} = FEATURES{4,i}(:);
    FEATURES{5,i} = FEATURES{5,i}/norm(FEATURES{5,i});
end


% ind2 = [];
% for i = 1:length(rows)
%    if(rows(i) >size(I,1)-5 || rows(i) < size(I,1)-5)
%        ind2 = [ind2,i];
%    end
% end
% rows(ind2) = [];
% cols(ind2) = [];

figure; imshow(I,[]);
hold on
for i = 1:length(squares)
    buff = squares{i};
   plot(buff(1,:),buff(2,:),'r');
end