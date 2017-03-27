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
SB=S_B0/7291;
SW=(S_W0)/7291;
%SW=(S_W0+eye(max(length(S_W0)))*0.000001)/7291;
%  
% %[X Y]=eig(SB,SW)
%  
%  
% %v=max(max((Y)));
v=2

%A=SW-v*SB;
A=-(SB-v*SW);
M=4;
W=rand(n1,M);
W2=W;
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=5*(R+R');
  
Iterations=500;
  
 r1=1;
  
r2=0.01;

 r12=0.4;
  
r22=0.002;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);
Cost5=zeros(Iterations,1);
Cost6=zeros(Iterations,1);
for k=1:Iterations;



DF1=2*A*W+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);
DF1=DF1/norm(DF1);
W=W-r1*DF1;

W=orth(W);

 
DF2=(2*(R.*(W'*W-I)).*(W'*W-I))+(2*(R.*(W'*W-I)).*(W'*W-I))'-diag(diag(2*(R.*(W'*W-I)).*(W'*W-I)));
DF2=DF2/norm(DF2);
 %if  Cost2(k)>0.01
     R=R+r2*DF2;
%end
      
      
Cost1(k)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
Cost3(k)=trace(W'*A*W);


%%%%%%%%%%%%
DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF3=DF3/norm(DF3);
W2=W2-r12*DF3;

%W2=orth(W2);
 
DF4=diag(diag(2*R2*W2'*W2*W2'*W2-4*R2*W2'*W2+2*R2));
DF4=DF4/norm(DF4);
% if  Cost2(k)>0.01
            R2=R2+r22*DF4;
%end
      
      
Cost4(k)=trace(W2'*A*W2)+trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);  
Cost5(k)=trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);
Cost6(k)=trace(W2'*A*W2);
 k 
end

figure(1)
plot(Cost1(1:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
 
figure(2)
plot(Cost2(1:Iterations),'r-*')

figure(3)
plot(Cost3(1:Iterations),'r-*')

figure(4)
plot(Cost4(1:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
 
figure(5)
plot(Cost5(1:Iterations),'r-*')

% figure(6)
% plot(Cost6(1:Iterations),'r-*')
 
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

 x1=W2'*fea_tr';
 x2_tr=x1';
x1_te=W2'*fea_te';
x2_te=x1_te';
 model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 3);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100