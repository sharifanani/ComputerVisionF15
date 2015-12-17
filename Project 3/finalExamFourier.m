close all
clear all
clc
load('imageData/ImagedataFlashlight64.mat')
n = size(X,2);
XT=X';
theta = pi/n;
[U,S,V] = svd(X,0);

%showing eigenimages
I=[];
for i = 1:5
   I=[I,reshape(U(:,i),[],128)];
end
figure
imshow(I,[])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%computation usually done offline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=n;
for k=0:N-1
    for l=0:N-1
        w(k+1,l+1)=cos((2*pi*k*l)/N)-1i*sin((2*pi*k*l)/N);
    end
end
F=w/sqrt(n);
H1 = (1/sqrt(2))*real(F(:,1));
H=[];
for i = 2:n
    H=[H,real(w(:,i)),imag(w(:,i))];
end
H=[H1,H]*sqrt(2);
Hf = H(:,1:n);

normXT = norm(XT,'fro')^2;
rho=0;
for i = 1:n
    rho = rho + (norm(H(:,i)'*XT,'fro')^2 / normXT);
    if(rho>0.99)
        break
    end
end
i

% H(:,2)=[];
% H(:,1)=H(:,1)/sqrt(2);
% H=H*sqrt(2);
Y=zeros(size(X));
for i = 1:size(Y,1)
   Y(i,:) = fft(X(i,:)); 
end

Y2=[];
Y2(:,1) = (1/sqrt(2))*real(Y(:,1));
for i = 2:size(Y,2)
    Y2 = [Y2,real(Y(:,i)),imag(Y(:,i))];
end
XH = Y2(:,1:5)*sqrt(2/2);


[U2,S2,V2] = svd(XH,0);
J=[];
for i = 1:5
   J=[J,reshape(U2(:,i),[],128)];
end
figure
imshow([J],[])
title('Eigenimage estimations for boat')