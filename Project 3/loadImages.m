clc
clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Load all images and store the data for later use.  You need to create
%  a new directory called MATDATA up two directories from the current directory.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Otable = {'Boat','Cabinet','Car','Chair','Cup','Flashlight','Handle',...
    'HoseReel','ibook01','imac04','imac98','Keyboard','LED','Light1',...
    'Light2','Mug','Scooter','SprayBottle','Stapler','Trash'};

b = 64;
n = 2*b;
m = 128;

for i=1:20
    object = [Otable{i} num2str(b)];
    XM = zeros(m^2,n);
    XT = zeros(m,n,m);
    for ImNum = 0:n-1        
        D = ['TrainingImages/' object '/UnProcessed/img_' num2str(ImNum) '.png'];
        I = im2double(imread(D));
        I = reshape(I,[],1);    
        X(:,ImNum+1) = I;
    end
    
    SD = ['Imagedata' object '.mat'];
    save(SD,'X');
    i
end
