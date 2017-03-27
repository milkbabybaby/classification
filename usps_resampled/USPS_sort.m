clear;
load('USPS.mat');	
fea_tr0=fea(1:7291,:);
lab_tr0=gnd(1:7291);
fea_te0=fea(7292:9298,:);
lab_te0=gnd(7292:9298,:);
train=[ fea_tr0, lab_tr0];
test=[ fea_te0, lab_te0];

train_sort=sortrows(train,257);


test_sort=sortrows(test,257);


i =1;
idx = find(lab_tr0 == i);
train_1=fea_tr0(idx,:);

i =2;
idx = find(lab_tr0 == i);
train_2=fea_tr0(idx,:);

i =3;
idx = find(lab_tr0 == i);
train_3=fea_tr0(idx,:);

i =4;
idx = find(lab_tr0 == i);
train_4=fea_tr0(idx,:);

i =5;
idx = find(lab_tr0 == i);
train_5=fea_tr0(idx,:);

i =6;
idx = find(lab_tr0 == i);
train_6=fea_tr0(idx,:);

i =7;
idx = find(lab_tr0 == i);
train_7=fea_tr0(idx,:);


i =8;
idx = find(lab_tr0 == i);
train_8=fea_tr0(idx,:);

i =9;
idx = find(lab_tr0 == i);
train_9=fea_tr0(idx,:);

i =10;
idx = find(lab_tr0 == i);
train_10=fea_tr0(idx,:);

fea_tr=train_sort(:,1:256);
lab_tr=train_sort(:,257);
fea_te=test_sort(:,1:256);
lab_te=test_sort(:,257);