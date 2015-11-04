close all
clear all
clc

I=imread('coins.png');
I2 = imrotate(I,45,'crop');
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
% remove duplicates
[d1,d2] = sort(MATCH(2,:));
MATCH = MATCH(:,d2);
ind=[];
% MATCH(1,:)=MATCH(1,:)/max(MATCH(1,:));
for i = 1:size(MATCH,2)
    if(MATCH(1,i)>MATCH(1,:)-3*std(MATCH(1,:)))
        ind=[ind,i];
    end
end
MATCH(:,ind)=[];
I3 = [I,I2];
figure;
imshow(I3,[]);hold on;
for i=1:size(MATCH,2)
   plot([FEATURES1{1,MATCH(3,i)}(2) , FEATURES2{1,MATCH(2,i)}(2)+size(I,1)],...
       [FEATURES1{1,MATCH(3,i)}(1), FEATURES2{1,MATCH(2,i)}(1)])
end
% 
% % figure;imshow(I,[]);hold on;plot(squares1{43}(1,:),squares1{43}(2,:))
% % figure;imshow(imrotate(I,45,'crop'),[]);hold on;plot(squares2{ind}(1,:),squares2{ind}(2,:))
% % figure;imshow(imresize(FEATURES1{3,10},5),[])
% % %-------debug code------%
% % figure;
% % for i = 1:size(FEATURES2,2)
% %     imshow(imresize(FEATURES2{3,i},5),[])
% %     i
% %     pause()
% % end