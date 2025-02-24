function [rows,cols] = detectCorners(I)

%make sure image is greyscale
if(numel(size(I)) >2)
    I=double(rgb2gray(I));
end

% I=histeq(I); %%histeq the image
% I = double(I); %change to double

%-------First and Second Derivatives-----%
G= fspecial('gaussian',6,1);
[Gx,Gy] = gradient(G);
Ix = conv2(I,Gx,'same'); Iy = conv2(I,Gy,'same');
Ix2 = Ix.*Ix; Iy2 = Iy.*Iy; Ixy = Ix.*Iy;
%---------------------------------------%

%----Calculate second derivatives-------%
Gw = fspecial('gaussian',36,1);
Sx2 = conv2(Ix2,Gw,'same'); Sy2 = conv2(Iy2,Gw,'same');
Sxy = conv2(Ixy,Gw,'same');
%---------------------------------------%
H = cell(size(Ix2));
R = zeros(size(Ix2));
k=0.04;

%----------Calculating the response-----%
for i = 1:size(Sx2,1)
    for j = 1:size(Sx2,2)
%         H{i,j} = [Sx2(i,j) Sxy(i,j); %cell previously used for better
%         readability
%             Sxy(i,j) Sy2(i,j)];
        R(i,j) = (Sx2(i,j)*Sy2(i,j) - Sxy(i,j)*Sxy(i,j)) - k*(Sx2(i,j)+Sy2(i,j))^2;
    end
end
%---------------------------------------%

J = abs(R(:)); %absolute of the image


t = 0.02*max(J);%thresholding to get corners, could be tuned a lot better
for i = 1:numel(J)
    if J(i)> t
        J(i) = 1;
    else
        J(i) = 0;
    end
end
J2 = reshape(J,size(R));
[cols,rows]=find(J2 == 1);
%-----non-maximum suppression----------%
% for i = 1:numel(rows)-1
%     for j = i+1:numel(cols)
%         if(J2(cols(j),rows(j))==1 && J2(cols(i),rows(i))==1)
%             dist = (rows(i) - rows (j))^2 + (cols(i)-cols(j))^2;
%             if(dist< 100 && R(cols(j),rows(j)) < R(cols(i),rows(i)))
%                 J2(cols(j),rows(j))=0;
%             elseif(dist < 100)
%                 J2(cols(i),rows(i))=0;
%             end
%         end
%     end
% end
supp =@(block_struct) suppressNonMax(double(block_struct.data));

J2 = blockproc(R,[45 45],supp);
%---------------------------------------%
[rows,cols]=find(J2 == 1);%return locations of corners
end