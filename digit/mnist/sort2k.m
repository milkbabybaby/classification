clear;
clc;
load('2k2k.mat');
no_fea =784;
fea_tr=fea(trainIdx,:);
lab_tr=gnd(trainIdx,:);
fea_te=fea(testIdx,:);
lab_te=gnd(testIdx,:);