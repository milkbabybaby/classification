
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

 
[m1,n1]=size(fea_tr);
SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;

BB=SB;
EE=SW;

BBB=SB;
EEE=SW;

no_select=7
 
  

WW=[];

traceP=[];

for kk=1:no_select
    
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
     mean_tr= mean(fea_tr0);   
     
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

B=S_B0;
E=S_W0+eye(max(length(S_W0)))*0.000001;
% E=S_W ;

[X Y]=eig(B,E)


[II JJ]=max(max((Y)));

W=X(:,JJ);

if kk==1
  W=W/norm(W);
WW=[WW  W];
P_g=WW*pinv(WW);
else

% W=(I-P_g)*W;
 W=W/norm(W);
WW=[WW  W];
P_g=WW*pinv(WW);
end

%WW=WW/norm(WW)
P1=W'*S_W0*W;
P2=W'*S_B0*W;

PP1=WW'*EEE*WW;
PP2=WW'*BBB*WW;


trace1(kk)=trace(P2)/trace(P1);
trace2(kk)=trace(PP2)/trace(PP1);

traceP=[traceP ; trace(P2) trace(P1)  trace(PP2) trace(PP1)] 

I=diag(ones(no_fea,1));
%  
 train_1=((I-P_g)*train_1')';
train_2=((I-P_g)*train_2')';
train_3=((I-P_g)*train_3')';
train_4=((I-P_g)*train_4')';
train_5=((I-P_g)*train_5')';
train_6=((I-P_g)*train_6')';
train_7=((I-P_g)*train_7')';
train_8=((I-P_g)*train_8')';
train_9=((I-P_g)*train_9')';
train_10=((I-P_g)*train_10')';
  

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