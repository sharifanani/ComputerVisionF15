close all
clear all
clc
files=ls;
files2 = strsplit(files);

for i = 1:numel(files2)-1
    filestr = files2{i};
    if(strcmp(filestr(end-3:end) ,'.JPG'))
        I = imread(filestr);
        newstr = strcat(filestr(1:end-3),'pgm');
        imwrite(I,newstr)
        fprintf('wrote\n')
    end
    
end