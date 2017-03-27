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




BBB=S_B0;
EEE=S_W0;

no_select=10

WW=[];

for k=1:no_select
  
    
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


B=S_B0;
E=S_W0;
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

train0=((I-P_g)*train0')';
train1=((I-P_g)*train1')';
train2=((I-P_g)*train2')';
train3=((I-P_g)*train3')';
train4=((I-P_g)*train4')';
train5=((I-P_g)*train5')';
train6=((I-P_g)*train6')';
train7=((I-P_g)*train7')';
train8=((I-P_g)*train8')';
train9=((I-P_g)*train9')';


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