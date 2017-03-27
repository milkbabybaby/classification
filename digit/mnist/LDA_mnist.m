clear;
clc;
load('mnist.mat');
no_fea =784;

t0=size(train0,1);
t1=size(train1,1);
t2=size(train2,1);
t3=size(train3,1);
t4=size(train4,1);
t5=size(train5,1);
t6=size(train6,1);
t7=size(train7,1);
t8=size(train8,1);
t9=size(train9,1);

mean_0=mean(train0);
mean_1=mean(train1);
mean_2=mean(train2);
mean_3=mean(train3);
mean_4=mean(train4);
mean_5=mean(train5);
mean_6=mean(train6);
mean_7=mean(train7);
mean_8=mean(train8);
mean_9=mean(train9);

mean_tr=mean(fea_tr);




S_B0=t0*(mean_0-mean_tr)'*(mean_0-mean_tr)+t1*(mean_1-mean_tr)'*(mean_1-mean_tr)+t2*(mean_2-mean_tr)'*(mean_2-mean_tr)+t3*(mean_3-mean_tr)'*(mean_3-mean_tr)+t4*(mean_4-mean_tr)'*(mean_4-mean_tr)+t5*(mean_5-mean_tr)'*(mean_5-mean_tr)+t6*(mean_6-mean_tr)'*(mean_6-mean_tr)+t7*(mean_7-mean_tr)'*(mean_7-mean_tr)+t8*(mean_8-mean_tr)'*(mean_8-mean_tr)+t9*(mean_9-mean_tr)'*(mean_9-mean_tr);

S_W0=zeros(no_fea,no_fea);
for i=1:t0
    S_W0=S_W0+(train0(i,:)-mean_0)'*(train0(i,:)-mean_0);
end
for i=1:t1
    S_W0=S_W0+(train1(i,:)-mean_1)'*(train1(i,:)-mean_1);
end

for i=1:t2
    S_W0=S_W0+(train2(i,:)-mean_2)'*(train2(i,:)-mean_2);
end

for i=1:t3
    S_W0=S_W0+(train3(i,:)-mean_3)'*(train3(i,:)-mean_3);
end

for i=1:t4
    S_W0=S_W0+(train4(i,:)-mean_4)'*(train4(i,:)-mean_4);
end

for i=1:t5
    S_W0=S_W0+(train5(i,:)-mean_5)'*(train5(i,:)-mean_5);
end

for i=1:t6
    S_W0=S_W0+(train6(i,:)-mean_6)'*(train6(i,:)-mean_6);
end

for i=1:t7
    S_W0=S_W0+(train7(i,:)-mean_7)'*(train7(i,:)-mean_7);
end

for i=1:t8
    S_W0=S_W0+(train8(i,:)-mean_8)'*(train8(i,:)-mean_8);
end

for i=1:t9
    S_W0=S_W0+(train9(i,:)-mean_9)'*(train9(i,:)-mean_9);
end

SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;

[V,D]=eig(SB,SW);

[X,I]=sort(diag(D), 'descend');
V=V(:,I);


M=5
W=[];
for i=1:M
%W=[W V(:,i)];    
W=[W V(:,i)/norm(V(:,i))];
end

trace(W'*SW*W)/trace(W'*SB*W)




 x1=W'*fea_tr';
 x2_tr=x1';
x1_te=W'*fea_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

