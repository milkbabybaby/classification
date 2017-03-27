
 clear;
clc;
load('USPS_ordered222.mat');
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

t1=767;
t2=622;
t3=475;
t4=406;
t5=409;
t6=361;
t7=420;
t8=390;
t9=377;
t10=422;

S_B0=t1*(mean_1-mean_tr)'*(mean_1-mean_tr)+t2*(mean_2-mean_tr)'*(mean_2-mean_tr)+t3*(mean_3-mean_tr)'*(mean_3-mean_tr)+t4*(mean_4-mean_tr)'*(mean_4-mean_tr)+t5*(mean_5-mean_tr)'*(mean_5-mean_tr)+t6*(mean_6-mean_tr)'*(mean_6-mean_tr)+t7*(mean_7-mean_tr)'*(mean_7-mean_tr)+t8*(mean_8-mean_tr)'*(mean_8-mean_tr)+t9*(mean_9-mean_tr)'*(mean_9-mean_tr)+t10*(mean_10-mean_tr)'*(mean_10-mean_tr);

S_W0=zeros(no_fea,no_fea);
for i=1:t1
    S_W0=S_W0+(train_1(i,:)-mean_1)'*(train_1(i,:)-mean_1);
end

for i=1:t2
    S_W0=S_W0+(train_2(i,:)-mean_2)'*(train_2(i,:)-mean_2);
end

for i=1:t3
    S_W0=S_W0+(train_3(i,:)-mean_3)'*(train_3(i,:)-mean_3);
end

for i=1:t4
    S_W0=S_W0+(train_4(i,:)-mean_4)'*(train_4(i,:)-mean_4);
end

for i=1:t5
    S_W0=S_W0+(train_5(i,:)-mean_5)'*(train_5(i,:)-mean_5);
end

for i=1:t6
    S_W0=S_W0+(train_6(i,:)-mean_6)'*(train_6(i,:)-mean_6);
end

for i=1:t7
    S_W0=S_W0+(train_7(i,:)-mean_7)'*(train_7(i,:)-mean_7);
end

for i=1:t8
    S_W0=S_W0+(train_8(i,:)-mean_8)'*(train_8(i,:)-mean_8);
end

for i=1:t9
    S_W0=S_W0+(train_9(i,:)-mean_9)'*(train_9(i,:)-mean_9);
end

for i=1:t10
    S_W0=S_W0+(train_10(i,:)-mean_10)'*(train_10(i,:)-mean_10);
end

 
[m1,n1]=size(fea_tr);
SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;

[V,D]=eig(SB,SW);

[X,I]=sort(diag(D), 'descend');
V=V(:,I);


M=10
W=[];
for i=1:M
W=[W V(:,i)];    
%W=[W V(:,i)/norm(V(:,i))];
end

trace(W'*SW*W)/trace(W'*SB*W)

 
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
