function [ imResult ] = corrImages( kernel,scene )
im1=double(kernel);im2=double(scene);
A=im1(:,:,1);B=im2(:,:,1);%extracting the L channel, this is the RGB image
m1=mean(A(:));m2=mean(B(:));%calculating the mean of every image
A=A-m1;B=B-m2;A=A./std(A(:));B=B./std(B(:));%subtracting the mean and
                                            %dividing by the std dev.
im1(:,:,1)=A;im2(:,:,1)=B;%putting back the L channel in the image
imResult = zeros(size(im2,1)-size(im1,1),size(im2,2)-size(im1,2),3);
targetPixel = [1,1];%pixel in the target image
%%
% Defininf the corners of the kernel, where they need to be on the image.
corners = [1,size(im1,1),1,size(im1,2)];
for k=1:3
    for j = 1:size(im2,1)-size(im1,1)
        for i = 1:size(im2,2)-size(im1,2)
            %extracts a patch from the image
            patch = im2(corners(1):corners(2),corners(3):corners(4),k);
            patch = patch.*im1(:,:,k);%elementwise multiplication
            val = sum(patch(:));%summation of all terms
            corners=corners + [0 0 1 1];%modifying corners to slide one
                                        %pixel to the right
            %use calculated value as pixel value
            imResult(targetPixel(1),targetPixel(2),k) = val;
            targetPixel(2)=targetPixel(2)+1;%modify target pixel index
        end
        %after finishing with row, move the corners to the start of the new
        %row
        corners=corners+[1 1 0 0]-[0 0 i i];
        targetPixel(1)=targetPixel(1)+1;
        targetPixel(2)=1;
    end
corners = [1,size(im1,1),1,size(im1,2)];
targetPixel=[1,1];
end

end

