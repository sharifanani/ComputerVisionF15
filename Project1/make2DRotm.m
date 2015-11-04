function [ rotm ] = make2DRotm( theta )
%MAKE2DROTM Summary of this function goes here
%   Detailed explanation goes here
rotm = [cos(theta),sin(theta);-sin(theta),cos(theta)];

end

