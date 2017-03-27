close all
clc;
clear;
tic;
load('Isolet1.mat');
ee=zeros(26,1);
for i= 1:26
e=find(gnd==i); 
ee(i,1)=length(e);
end 
