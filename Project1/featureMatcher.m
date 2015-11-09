close all
clear all
clc
I_orig=imresize(imread('wall/img1.ppm'),0.5);
I=rgb2gray(I_orig);
I2_orig = imresize(imread('wall/img2.ppm'),0.5);
I2 = rgb2gray(I2_orig);
load('FEATURES1.mat');
FEATURES1=FEATURES;
squares1=squares';
load('FEATURES2.mat');
FEATURES2=FEATURES;
squares2 = squares';
clear FEATURES;
clear squares;
SIMILARITIES = cell(size(FEATURES1,2),size(FEATURES2,2));
SADS = zeros(size(SIMILARITIES));
MATCH = zeros(2,size(FEATURES1,2));
for i = 1 : size(FEATURES1,2)
    for j = 1:size(FEATURES2,2)
        SIMILARITIES{i,j} = abs(FEATURES1{3,i} - FEATURES2{3,j});
        SADS(i,j) = sum(SIMILARITIES{i,j}(:)); %SAD
    end
end
% extract all possible matches
for i = 1:size(SADS,1)
    [val,ind] = min(SADS(i,:));
    MATCH(1,i) = val;
    MATCH(2,i) = ind;
    MATCH(3,i) = i;
end
% sorting by SAD
[d1,d2] = sort(MATCH(1,:));
MATCH = MATCH(:,d2);
squares1=squares1(:,MATCH(3,:));
squares2=squares2(:,MATCH(2,:));
ind=[];
k=1.4;
% removing nonprobable matches
    for i = 1:size(MATCH,2)
        if(MATCH(1,i)> mean(MATCH(1,:)) - k*std(MATCH(1,:)))
            ind=[ind,i];
        end
        
    end

MATCH(:,ind)=[];
squares1(:,ind) = [];
squares2(:,ind) = [];
%removing duplicates
[C,ia,ic]=unique(MATCH(2,:));
MATCH2 = MATCH(:,ia);
squares1 = squares1(:,ia);
squares2=squares2(:,ia);
I3 = [I_orig,I2_orig];
hfig = figure;
him = imshow(I3,[]);
imscrollpanel(hfig,him);
hold on;
col = ['m' 'c' 'r' 'g' 'b'];
for i=1:size(MATCH2,2)
    
    c = col(1+(mod(i,numel(col))));
    plot([FEATURES1{1,MATCH2(3,i)}(2) , FEATURES2{1,MATCH2(2,i)}(2)+size(I,2)],...
        [FEATURES1{1,MATCH2(3,i)}(1), FEATURES2{1,MATCH2(2,i)}(1)],'LineWidth',1)
    buf1=squares1{i};buf2=squares2{i};
    plot(buf1(1,:),buf1(2,:),c);
    plot(buf2(1,:)+size(I,2),buf2(2,:),c);
end