 clear;
clc;
load('USPS_all.mat');
for k=1:10
    fea(:,:,k)=double(data(:,:,k)');
end 
