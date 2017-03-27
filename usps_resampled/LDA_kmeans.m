clear;
clc;
load('USPS_sort.mat');
no_fea =256;
mean_1=mean(train_1);
mean_2=mean(train_2);
mean_3=mean(train_3);
mean_4=mean(train_4);
mean_5=mean(train_5);
mean_6=mean(train_6);
mean_7=mean(train_7);
mean_8=mean(train_8);
mean_9=mean(train_9);
mean_10=mean(train_10);
mean_tr=mean(fea_tr);



S_W0=zeros(no_fea,no_fea);
S_B0=zeros(no_fea,no_fea);

S_B0=1194*(mean_1-mean_tr)'*(mean_1-mean_tr)+1005*(mean_2-mean_tr)'*(mean_2-mean_tr)+731*(mean_3-mean_tr)'*(mean_3-mean_tr)+658*(mean_4-mean_tr)'*(mean_4-mean_tr)+652*(mean_5-mean_tr)'*(mean_5-mean_tr)+556*(mean_6-mean_tr)'*(mean_6-mean_tr)+664*(mean_7-mean_tr)'*(mean_7-mean_tr)+645*(mean_8-mean_tr)'*(mean_8-mean_tr)+542*(mean_9-mean_tr)'*(mean_9-mean_tr)+644*(mean_10-mean_tr)'*(mean_10-mean_tr);

S_W0=zeros(no_fea,no_fea);
for i=1:1194
    S_W0=S_W0+(train_1(i,:)-mean_1)'*(train_1(i,:)-mean_1);
end

for i=1:1005
    S_W0=S_W0+(train_2(i,:)-mean_2)'*(train_2(i,:)-mean_2);
end

for i=1:731
    S_W0=S_W0+(train_3(i,:)-mean_3)'*(train_3(i,:)-mean_3);
end

for i=1:658
    S_W0=S_W0+(train_4(i,:)-mean_4)'*(train_4(i,:)-mean_4);
end

for i=1:652
    S_W0=S_W0+(train_5(i,:)-mean_5)'*(train_5(i,:)-mean_5);
end

for i=1:556
    S_W0=S_W0+(train_6(i,:)-mean_6)'*(train_6(i,:)-mean_6);
end

for i=1:664
    S_W0=S_W0+(train_7(i,:)-mean_7)'*(train_7(i,:)-mean_7);
end

for i=1:645
    S_W0=S_W0+(train_8(i,:)-mean_8)'*(train_8(i,:)-mean_8);
end

for i=1:542
    S_W0=S_W0+(train_9(i,:)-mean_9)'*(train_9(i,:)-mean_9);
end

for i=1:644
    S_W0=S_W0+(train_10(i,:)-mean_10)'*(train_10(i,:)-mean_10);
end
%train_1
kk=400;

[IDX,C] = kmeans(train_1,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_1(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end

% train_2

[IDX,C] = kmeans(train_2,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_2(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end

% train_3
[IDX,C] = kmeans(train_3,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_3(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end

% train_4
[IDX,C] = kmeans(train_4,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_4(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end


% train_5
[IDX,C] = kmeans(train_5,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_5(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end


% train_6
[IDX,C] = kmeans(train_6,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_6(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end

% train_7
[IDX,C] = kmeans(train_7,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_7(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end


% train_8
[IDX,C] = kmeans(train_8,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_8(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end


% train_9
[IDX,C] = kmeans(train_9,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_9(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end


% train_10
[IDX,C] = kmeans(train_10,kk);
for i=1:kk
trainIdx =find (IDX == i);  
b=length(trainIdx);
subclass=train_10(trainIdx,:);
  for k=1:b
    S_W0=(subclass(k,:)-C(i,:))'*(subclass(k,:)-C(i,:))+S_W0;
  end
S_B0=b*(C(i,:)-mean_tr)'*(C(i,:)-mean_tr)+S_B0;
end


[m1,n1]=size(fea_tr);
SB=S_B0/7291;
SW=(S_W0)/7291;

M=3
[V,D]=eig(SB,SW);
W=[];
for i=1:M
    
W=[W V(:,i)];
end

trace(W'*SW*W)/trace(W'*SB*W);
 
 x1=W'*fea_tr';
 x2_tr=x1';
x1_te=W'*fea_te';
x2_te=x1_te';

model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
[predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 3);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
