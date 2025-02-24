function [ J ] = threshImg( I )
%THRESHIMG Summary of this function goes here
%   Detailed explanation goes here
    J=zeros(size(I));
    I2 = I(:);
    %start by normalizing the image
    I2 = I2 - mean(I2);
    I2 = I2 ./ std(I2);
    
    %thresholding the image
    for k = 1:length(I2)
       if (abs(I2(k)) > 1.5)
           I2(k) = 1;
       else
           I2(k) = 0;
       end
    end
    J=reshape(I2,size(I));

end

