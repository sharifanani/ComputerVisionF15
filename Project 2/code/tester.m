close all
clear all
clc

I1 = imread('DSC_0196.JPG');
I2 = imread('DSC_0197.JPG');
I1 = imresize(I1,0.1);I2 = imresize(I2,0.1);
I1g = (rgb2gray(I1));
I2g = (rgb2gray(I2));
[pts1,pts2] = extractandMatchFeatures(I1g,I2g);
locs1 = pts1.Location;
locs2 = pts2.Location;
A = zeros(size(locs1,1),9);
i=1;
c=1;
while(c<=size(locs1,1))
    x1 = locs1(c,1);y1=locs1(c,2);X1=locs2(c,1);Y1=locs2(c,2);
    A(i,:) = [x1,y1,1,0,0,0,-x1*X1,-y1*X1,-X1];
    A(i+1,:) = [0,0,0,x1,y1,1,-x1*Y1,-y1*Y1,-Y1];
    c=c+1;
    i=i+2;
end
j=1;
B = A(j:j+7,:);
N = null(B);
H = [N(1) N(2) N(3);
    N(4) N(5) N(6);
    N(7) N(8) N(9)];
% H = inv(H);
H=H/H(end,end);
Hinv = inv(H);
Hinv = Hinv/Hinv(end,end);
%%
% H matix testing
xLocs1 = locs1(:,1)';
yLocs1 = locs1(:,2)';
xLocs2 = locs2(:,1)';
yLocs2 = locs2(:,2)';
homog = ones(size(xLocs2));
Locs1 = [xLocs1;yLocs1];
Locs2 = [xLocs2;yLocs2;homog];
Locs2T = Hinv*Locs2;
for i = 1:size(Locs2T,2)
   v=Locs2T(:,i);
   s=v(3);
   Locs2T(:,i) = Locs2T(:,i)/s;
end
Locs2T(3,:) = [];
d = Locs1 - Locs2T;
%% Warping the corners of the second image
%Picking corners for the new image to host both images
[h,w] = size(I2g);
[h1,w1] = size(I1g);
I2Corners = [1,1,w,w;
             1,h,1,h;
             1,1,1,1];
warpedCorners = Hinv*I2Corners;
for i = 1:size(warpedCorners,2)
    v=warpedCorners(:,i);
    s=v(3);
    warpedCorners(:,i)=warpedCorners(:,i)/s;
end
% choose limits w.r.t first image to make sure both grids will fit
xCoords = min([warpedCorners(1,:),0]):max([warpedCorners(1,:),w1]);
yCoords = min([warpedCorners(2,:),0]):max([warpedCorners(2,:),h1]);
[X,Y]=meshgrid(xCoords,yCoords);
% Transform new grid back to image 2
C = H*[X(:),Y(:),ones(numel(X(:)),1)]';
for i = 1:size(C,2)
   v = C(:,i);
   s = v(3);
   C(:,i)=v/s;
end
xNew = reshape(C(1,:),size(X)); %remaking into a grid
yNew = reshape(C(2,:),size(X));
% interpolate the image into the new grid
I2w = interp2(double(I2g),xNew,yNew); 
figure
imshow(I2w,[])
% offset image 1
offsetOldImage = -round([min([warpedCorners(1,:),0]),...
    min([warpedCorners(2,:),0])]);
I2w(1+offsetOldImage(2):h1+offsetOldImage(2),1+offsetOldImage(1):w1+offsetOldImage(1),:) =...
    double(I1g(1:h1,1:w1));
figure;
imshow(I2w,[])
