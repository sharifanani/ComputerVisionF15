close all
clear
clc

I = rand(256);
Z = zeros(size(I));
[row,col] = find(I == max(I(:)));
I(row,col)
Z(row,col) = 1;
I = I.*Z;
