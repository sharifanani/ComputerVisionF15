function imResult = mosaic_color(I1, I2, method)
warning('off','all');
if(nargin<3)
    error('THREE INPUTS DAWG');
end
I1 = imresize(I1,[600,NaN] );I2 = imresize(I2,[600,NaN]);
I1g = (rgb2gray(I1));
I2g = (rgb2gray(I2));
if(strcmp(method,'manual')==1)
    manual=1;
else
    manual=0;
end
if(manual)
    figure;imshow(I1,[]);
    [locs1] = ginput(4);
    close all
    figure;imshow(I2,[]);
    [locs2] = ginput(4);
    close
else
    [pts1,pts2] = extractandMatchFeatures(I1g,I2g);
    locs1 = pts1.Location;
    locs2 = pts2.Location;
end
H=homogRANSAC(locs1,locs2,5e3);
H=H/H(end,end);
Hinv = inv(H);
Hinv = Hinv/Hinv(end,end);
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
I2r = interp2(double(I2(:,:,1)),xNew,yNew);
I2g = interp2(double(I2(:,:,2)),xNew,yNew);
I2b = interp2(double(I2(:,:,3)),xNew,yNew);
I2w(:,:,1)=I2r;
I2w(:,:,2)=I2g;
I2w(:,:,3)=I2b;
I2w(isnan(I2w)) = 0; % I dont like NaNs
% figure;
% imshow(I2w/255,[]);
% offsetting the old image to fit on the new canvas/meshgrid
offsetOldImage = -round([min([warpedCorners(1,:),0]),...
    min([warpedCorners(2,:),0])]);
%extract coordinates for old image in new canvas
limH = 1+offsetOldImage(2):h1+offsetOldImage(2);
limW = 1+offsetOldImage(1):w1+offsetOldImage(1);
I2w(limH,limW,:) = double(I1(1:h1,1:w1,:));
imResult = I2w/255;
warning('on','all');
end
