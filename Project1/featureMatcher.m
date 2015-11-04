close all
clear all
clc
I_orig=(imread('Yosemite1.jpg'));
I=rgb2gray(imread('Yosemite1.jpg'));
I2_orig = (imread('Yosemite2.jpg'));
I2 = rgb2gray(imread('Yosemite2.jpg'));
load('FEATURES1.mat');
FEATURES1=FEATURES;
squares1=squares;
load('FEATURES2.mat');
FEATURES2=FEATURES;
squares2 = squares;
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
ind=[];
% removing nonprobable matches
mean(MATCH(1,:)) - 1*std(MATCH(1,:))
for i = 1:size(MATCH,2)
    if(MATCH(1,i)> mean(MATCH(1,:)) - 1.5*std(MATCH(1,:)))
        ind=[ind,i];
    end
end
MATCH(:,ind)=[];

%removing duplicates
[C,ia,ic]=unique(MATCH(2,:));
MATCH2 = MATCH(:,ia);

I3 = [I_orig,I2_orig];
figure;
imshow(I3,[]);hold on;
for i=1:size(MATCH2,2)
   plot([FEATURES1{1,MATCH2(3,i)}(2) , FEATURES2{1,MATCH2(2,i)}(2)+size(I,2)],...
       [FEATURES1{1,MATCH2(3,i)}(1), FEATURES2{1,MATCH2(2,i)}(1)])
end