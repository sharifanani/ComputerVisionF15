function [FEATURES,squares] = makeFeatures (I)
if(ischar(I))
    I = imread(I);
end
% if(size(I,1)>800)
%     I = imresize(I,800/size(I,1));
% end
I_original = I;
if(numel(size(I)) >2)
    I=(rgb2gray(I));
end
I = histeq(I);
I = double(I);
I = (I-mean(I(:)))./std(I(:));
[rows,cols] = cornerDetection(I);
I = double(I);
G = fspecial('gaussian',3,1);
[Gx,Gy] = gradient(G);
Hx = conv2(I,Gx,'same');
Hy = conv2(I,Gy,'same');
H = Hx+Hy;
bound = 10;
%% get the square points
ind1 = [];
for i = 1:length(rows)
    if((rows(i) >= size(I,1)-bound) || rows(i)<=bound)
        ind1 = [ind1,i];
    end
end
rows(ind1) = [];
cols(ind1) = [];

ind1 = [];
for i = 1:length(cols)
    if((cols(i) <= bound) || cols(i) >= size(I,2)-bound)
        ind1 = [ind1,i];
    end
end
rows(ind1) = [];
cols(ind1) = [];
% gradAtPoints1 = zeros(1,length(rows));
% gradAtPoints2 = zeros(2,length(rows));
angles = zeros(size(rows));
%% get the dominant gradient at all corner points
pSize = 10;
qSize = 5;

FEATURES = cell(5,size(rows,2)); %cell array to hold all information

for i = 1:length(rows)
    patch_x = Hx(rows(i)-pSize:rows(i)+pSize,cols(i)-pSize:cols(i)+pSize);
    patch_y = Hy(rows(i)-pSize:rows(i)+pSize,cols(i)-pSize:cols(i)+pSize);
    patch_I = I(rows(i)-pSize:rows(i)+pSize,cols(i)-pSize:cols(i)+pSize);
    dominantGradientX = mean(patch_x(:));
    dominantGradientY = mean(patch_y(:));
    angles(i) = atan2(dominantGradientY,dominantGradientX);
    patch_I_rot = imrotate(patch_I,angles(i)*180/pi,'crop');
    p2 = patch_I_rot(ceil(size(patch_I_rot,1)/2)-qSize:ceil(size(patch_I_rot,1)/2)+qSize,...
        ceil(size(patch_I_rot,2)/2)-qSize:ceil(size(patch_I_rot,2)/2)+qSize);
    %     floor(size(patch_I_rot,1)/2)-2  floor(size(patch_I_rot,2)/2)-2
    FEATURES{1,i} = [rows(i),cols(i)]; %save poisition of feature
    FEATURES{2,i} = patch_I;
    FEATURES{3,i} = p2;
    FEATURES{4,i} = p2(:) / norm(p2(:));
    
end

squares = cell(size(rows));
for i = 1:length(squares)
    squares{i} = getSquare(10,angles(i),cols(i),rows(i));
    
end
% figure; imshow(I_original,[]);
% hold on
% for i = 1:length(squares)
%     buff = squares{i};
%     plot(buff(1,:),buff(2,:),'r');
% end
end