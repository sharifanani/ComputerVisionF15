function [SQF] = getSquare(scale,theta,x_tran,y_tran)
%getSquare [SQF] = Function that returns the coordinates of a square after rotating
%and translating
%   scale: scaling the length of the side of the square. Original length =1
%   theta: angle of rotation (radians c-clockwise from vertically down)
%   x_tran y_tran: new center of the square

% if(numel(size(I))>2)
%     I=rgb2gray(I);
% end
% I=histeq(I);
% I=double(I);
%% Defining the vertices of the square
% defines the vertices of a square to with size of one square pixel
%% Definig the square for plotting
hom = 1/scale;
SQ2 = scale*[0,0,0.5,0.5,-0.5,-0.5,0;0,0.5,0.5,-0.5,-0.5,0.5,0.5;hom*ones(1,7)];
theta=theta+pi/2; %adjusting for image
%% Defining the homography
rotm = [cos(theta),-sin(theta);sin(theta),cos(theta)];%angle2dcm(0,0,pi/2,'XYZ');
transm = [x_tran;y_tran]; %translate
homog = [rotm,transm];
homog = [homog;[0 0 1]];
% figure;plot(SQ2(1,:),SQ2(2,:));axis([-3 3 -3 3])
SQ3 = zeros(size(SQ2));
for i = 1:size(SQ2,2)
    SQ3(:,i) = homog*SQ2(:,i);
end
SQF = SQ3(1:2,:);
