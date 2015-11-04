close all;clear all;clc
lst=webcamlist;
cam1=webcam(1);
cam2=webcam(3);
figure(1);
preview(cam1)
figure(2);
preview(cam2)
i=0;
numImagePairs=15;
imageFiles1=cell(15,1);
imageFiles2=cell(15,1);
for j=1:30
   fprintf('Capturing in %i seconds\n',30-j); 
   pause(1)
end
while(1)
    pause(5);
    i=i+1;
    imageFiles1(i)={(snapshot(cam1))};
    imageFiles2(i)={(snapshot(cam2))};
    fprintf('captured %i images\n',i);
    if(i>=numImagePairs)
        break
    end
end
save('imdata.mat','imageFiles1','imageFiles2');
fprintf('Images saved to imdata.mat\n');
clear cam1
clear cam2
close all