function [ corners ] = getRect( center,height,width )
%GETRECT Summary of this function goes here
corners1 = [center(1) - width/2 , center(1) + width/2];
corners2 = [center(2) - height/2 , center(2) + height/2];
corners = corners1
end

