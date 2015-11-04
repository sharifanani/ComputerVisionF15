%% Computer Vision Fall 2015

%% Sharif Anani
close all
clear all
clc
v1 = [0;0;0];
v2 = [1;0;0];
v3 = [1;1;0];
v4 = [0;1;0];
v5 = [0;0;1];
v6 = [1;0;1];
v7 = [1;1;1];
v8 = [0;1;1];
CUBE = [v1 v2 v3 v4 v1 v5 v6 v7 v8 v5 v6 v2 v3 v7 v8 v4];
X = CUBE(1,:);
Y = CUBE(2,:);
Z = CUBE(3,:);
% figure(1)
% plot3(X,Y,Z);
% grid on
% xlim([-2,2]);ylim([-2,2]);zlim([-2,2]);
% title('Cube without any transofrmations')
%% Addring the (1) for homogeneity
CUBE = [CUBE;ones(1,length(CUBE))];
plot3(X,Y,Z);
% axis tight manual
frames(75) = struct('cdata',[],'colormap',[]);
ax = gca;
axis([-1 3 -1 4 -1 2])
title('Cube during transofrmations')
grid on
ax.NextPlot = 'replaceChildren';
%% Creating the homogeneous transformation matrix
for j = 1:75
    rotm=angle2dcm(j*pi/75,j*pi/75,j*pi/75,'XYZ');
    transm = [j/75;j/35;0];
    homog = [rotm,transm];
    homog = [homog;[0 0 0 1]];
    CUBE2=zeros(size(CUBE));
    %% Exexcuting the transformation
    for i=1:length(CUBE)
        CUBE2(:,i)=homog*CUBE(:,i);
    end
    X2 = CUBE2(1,:);
    Y2 = CUBE2(2,:);
    Z2 = CUBE2(3,:);
    plot3(X2,Y2,Z2);
    drawnow
    frames(j)=getframe(gcf);

end

v = VideoWriter('homog.avi');
open(v);
for j = 1:75
writeVideo(v,frames(j))
end
close(v)
