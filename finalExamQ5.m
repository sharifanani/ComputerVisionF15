close all
clear all
clc
t = 0:.1:10;
x = t;
x=awgn(x,0.1);
X = [x;t];
[u,s,v] = svd(X);
figure;
plot(X(1,:),X(2,:),'*');hold on;
ut=u';
plot(ut(1,:),ut(2,:));
X2 = u'*X;
x2=X2(1,:);
t2=X2(2,:);
figure;
plot(t,x,'*');
figure;
plot(t2,x2,'*')
