close all
clear all
clc
r=1;
t=-pi:0.1:pi;
y=r*sin(t);
x=r*cos(t);
x2=awgn(x,30);
y2=awgn(y,30);
figure;plot(x,y,'*r')
figure;plot(x2,y2,'*b')
X=[x2;y2];
[u,s,v]=svd(X);
X2= u'*X;
figure;
plot(X2(1,:),X2(2,:),'o');