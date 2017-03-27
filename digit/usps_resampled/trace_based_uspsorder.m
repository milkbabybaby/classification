clear;
clc;
load('USPS_ordered222.mat');
no_fea =256;
fea_tr=[train_1;train_2;train_3;train_4;train_5;train_6;train_7;train_8;train_9;train_10];


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


t1=size(train_1,1);
t2=size(train_2,1);
t3=size(train_3,1);
t4=size(train_4,1);
t5=size(train_5,1);
t6=size(train_6,1);
t7=size(train_7,1);
t8=size(train_8,1);
t9=size(train_9,1);
t10=size(train_10,1);

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


BBB=S_B0;
EEE=S_W0;

no_select=

WW=[];

for k=1:no_select
    
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
fea_tr0=[train_1;train_2;train_3;train_4;train_5;train_6;train_7;train_8;train_9;train_10];
mean_tr=mean(fea_tr0);

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

B=S_B0;
E=S_W0+eye(max(length(S_W0)))*0.000001;
% E=S_W ;

[X Y]=eig(B,E);


[II JJ]=max(max((Y)));

W=X(:,JJ);

if k==1
  W=W/norm(W);
WW=[WW  W];
P_g=WW*pinv(WW);
else

% W=(I-P_g)*W;
 W=W/norm(W);
WW=[WW  W];
P_g=WW*pinv(WW);
end


I=diag(ones(no_fea,1));

AA_1=train_1*(I-P_g)';
AA_2=train_2*(I-P_g)';
AA_3=train_3*(I-P_g)';
AA_4=train_4*(I-P_g)';
AA_5=train_5*(I-P_g)';
AA_6=train_6*(I-P_g)';
AA_7=train_7*(I-P_g)';
AA_8=train_8*(I-P_g)';
AA_9=train_9*(I-P_g)';
AA_10=train_10*(I-P_g)';

train_1=AA_1;
train_2=AA_2;
train_3=AA_3;
train_4=AA_4;
train_5=AA_5;
train_6=AA_6;
train_7=AA_7;
train_8=AA_8;
train_9=AA_9;
train_10=AA_10;

P1=W'*S_W0*W;
P2=W'*S_B0*W;

PP1=WW'*EEE*WW;
PP2=WW'*BBB*WW;


trace1(k)=trace(P2)/trace(P1);
trace2(k)=trace(PP2)/trace(PP1);

k
end
 
 x1=WW'*fea_tr';
 x2_tr=x1';
x1_te=WW'*fea_te';
x2_te=x1_te';

model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
[predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 3);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

figure(1)
 plot(trace1,'r-*')

  figure(2)
plot(trace2,'b-*')