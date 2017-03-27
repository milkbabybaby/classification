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


l1=length(train_1);
l2=length(train_2);
l3=length(train_3);
l4=length(train_4);
l5=length(train_5);
l6=length(train_6);
l7=length(train_7);
l8=length(train_8);
l9=length(train_9);
l10=length(train_10);


S_W0=zeros(no_fea,no_fea);
S_B0=zeros(no_fea,no_fea);


S_B0=1194*(mean_1-mean_tr)'*(mean_1-mean_tr)+1005*(mean_2-mean_tr)'*(mean_2-mean_tr)+731*(mean_3-mean_tr)'*(mean_3-mean_tr)+658*(mean_4-mean_tr)'*(mean_4-mean_tr)+652*(mean_5-mean_tr)'*(mean_5-mean_tr)+556*(mean_6-mean_tr)'*(mean_6-mean_tr)+664*(mean_7-mean_tr)'*(mean_7-mean_tr)+645*(mean_8-mean_tr)'*(mean_8-mean_tr)+542*(mean_9-mean_tr)'*(mean_9-mean_tr)+644*(mean_10-mean_tr)'*(mean_10-mean_tr);



kk=3;

%train_1

for i=1:l1
  for k=1:kk
IDX = knnsearch(train_1,train_1,'K',kk);
S_W0=S_W0+(train_1(IDX(i,k),:)-mean_1)'*(train_1(IDX(i,k),:)-mean_1);
  end 
end

%train_2
for i=1:l2
  for k=1:kk
IDX = knnsearch(train_2,train_2,'K',kk);
S_W0=S_W0+(train_2(IDX(i,k),:)-mean_2)'*(train_2(IDX(i,k),:)-mean_2);
  end 
end

%train_3
for i=1:l3
  for k=1:kk
IDX = knnsearch(train_3,train_3,'K',kk);
S_W0=S_W0+(train_3(IDX(i,k),:)-mean_3)'*(train_3(IDX(i,k),:)-mean_3);
  end 
end

%train_4
for i=1:l4
  for k=1:kk
IDX = knnsearch(train_4,train_4,'K',kk);
S_W0=S_W0+(train_4(IDX(i,k),:)-mean_4)'*(train_4(IDX(i,k),:)-mean_4);
  end 
end


%train_5
for i=1:l5
  for k=1:kk
IDX = knnsearch(train_5,train_5,'K',kk);
S_W0=S_W0+(train_5(IDX(i,k),:)-mean_5)'*(train_5(IDX(i,k),:)-mean_5);
  end 
end

%train_6
for i=1:l6
  for k=1:kk
IDX = knnsearch(train_6,train_6,'K',kk);
S_W0=S_W0+(train_6(IDX(i,k),:)-mean_6)'*(train_6(IDX(i,k),:)-mean_6);
  end 
end

%train_7
for i=1:l7
  for k=1:kk
IDX = knnsearch(train_7,train_7,'K',kk);
S_W0=S_W0+(train_7(IDX(i,k),:)-mean_7)'*(train_7(IDX(i,k),:)-mean_7);
  end 
end

%train_8
for i=1:l8
  for k=1:kk
IDX = knnsearch(train_8,train_8,'K',kk);
S_W0=S_W0+(train_8(IDX(i,k),:)-mean_8)'*(train_8(IDX(i,k),:)-mean_8);
  end 
end

%train_9
for i=1:l9
  for k=1:kk
IDX = knnsearch(train_9,train_9,'K',kk);
S_W0=S_W0+(train_9(IDX(i,k),:)-mean_9)'*(train_9(IDX(i,k),:)-mean_9);
  end 
end

%train_10
for i=1:l10
  for k=1:kk
IDX = knnsearch(train_10,train_10,'K',kk);
S_W0=S_W0+(train_10(IDX(i,k),:)-mean_10)'*(train_10(IDX(i,k),:)-mean_10);
  end 
end


[m1,n1]=size(fea_tr);
SB=S_B0/7291;
SW=(S_W0)/7291;

M=3

[V,D]=eig(3*SB,SW);
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

