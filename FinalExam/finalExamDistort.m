function [Iout] = finalExamDistort(I,str,k)
% I = imread('cameraman.tif');
% I=checkerboard(20);
if(~isfloat(I))
I=double(I);
end

[y,x]=size(I);%create coordinate system
c2 = round(y/2);c1=round(x/2);
center = [c1,c2];
Y = 1:y;%vertical coordinate
X = 1:x;%horizontal coordinate
[X,Y]=meshgrid(X,Y);
X = X-c1;%center at zero
Y = Y-c2;%center at zero
X=X(:);
Y=Y(:);
R = sqrt(c1^2 + c2^2);
[t,r] = cart2pol(X,Y);%make polar, because distortion will be working on rho
%normalize/distort/denormalize
r=r/R;
r2=r.*(1+k.*(r.^2));
r2=r2.*R;
%make the new coordinates bigger to fit
r2=r2 /(1 + k*(min(center)/R)^2);
%back to cartesian and original center
[x2,y2]=pol2cart(t,r2);
x2=x2+c1;
y2=y2+c2;
% [X2,Y2]=meshgrid(x2,y2);
x2=reshape(x2,size(I));
y2=reshape(y2,size(I));
% interpolate over new mesh
I2 = interp2(I,x2,y2,'cubic');
Iout=I2;
end