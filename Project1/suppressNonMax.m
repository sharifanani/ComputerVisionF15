function [B] = suppressNonMax( I )
Z = zeros(size(I));
[row,col] = find(I == max(I(:)));
Z(row,col) = 1/max(I(:));
B = I.*Z;
end

