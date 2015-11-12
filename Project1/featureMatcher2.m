function [] = featureMatcher2(FEATURES1,FEATURES2,squares1,squares2,I1,I2,thresh)
similarities = zeros(size(FEATURES1,2),size(FEATURES2,2));
matches=[];
for i = 1:size(similarities,1);
    for j = 1:size(similarities,2)
        similarities(i,j) = sum(abs(FEATURES1{4,i}-FEATURES2{4,j}))^2;
    end
end
%ratio test
for i = 1 : size(similarities,1)
    [B,J] = sort(similarities(i,:));
    if(B(1)/B(2) < thresh)
        m = [i;J(1)];
        matches = [matches,m];
    end
end
ctr=zeros(1,size(matches,2));
for i=1:size(matches,2)
    val=matches(2,i);
    for j=1:size(matches,2)
        if matches(2,j) == val
            ctr(i)=ctr(i)+1;
        end
    end
end
idxs = [];
for i=1:size(ctr,2)
   if ctr(i)>1
       idxs=[idxs,i];
   end
end
matches(:,idxs)=[];
sizediff = size(I1) - size(I2);
I2 = padarray(I2,sizediff,'post');
I3 = [I1,I2];
figure;imshow(I3,[])

hold on
col = ['m' 'c' 'r' 'g' 'b'];
for i= 1:size(matches,2)
    match1 = matches(1,i);
    match2 = matches(2,i);
    x = [FEATURES1{1,match1}(2), FEATURES2{1,match2}(2) + size(I2,2)];
    y = [FEATURES1{1,match1}(1), FEATURES2{1,match2}(1)];
    c = col(1+(mod(i,numel(col))));
    plot(x,y,'LineWidth',1)
    buf1=squares1{match1};buf2=squares2{match2};
    plot(buf1(1,:),buf1(2,:),c);
    plot(buf2(1,:)+size(I1,2),buf2(2,:),c);
end
end