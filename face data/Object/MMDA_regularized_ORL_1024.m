%  10 examples per class;  40 classes ; 400 examples in total;
clear;
clc;

tic;

load('ORL_Scale_32x32.mat');
no_fea =1024;
class_num=40;
ex_num=10;
tr_num=5;
te_num=10-tr_num;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];



 for k=1:class_num
  A_tr(1:tr_num,1:1024,k)=fea((k-1)*ex_num+1:(k-1)*ex_num+tr_num,:);
  B_tr(k,1:1024)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*ex_num+1:(k-1)*ex_num+tr_num)];
  A_te(1:te_num,1:1024,k)=fea((k-1)*ex_num+tr_num+1:ex_num*k,:);
  lab_te=[lab_te;gnd((k-1)*ex_num+tr_num+1:ex_num*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
mean_B=mean(B_tr);

S_B0=zeros(no_fea,no_fea);
 for k=1:class_num
 S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end

S_W0=zeros(no_fea,no_fea);
for k=1:class_num
    for i=1:tr_num
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end


[m1,n1]=size(fea);
SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;
% %v=max(max((Y)));
v=20
p=10;
pp=10;
A=SW-v*SB;
%A=-(SB-v*SW);
M=80;
W=rand(n1,M);

W0=W;
W00=W;

W2=rand(n1,M);
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';
R0=R;
R00=R;
  
Iterations=500;
  
 r1=0.5;
  
r2=0.1;

 r12=0.5;
  
r22=0.1;

 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);
Cost5=zeros(Iterations,1);
Cost6=zeros(Iterations,1);
Cost7=zeros(Iterations,1);
Cost8=zeros(Iterations,1);

for k=1:Iterations;

%%%%%% symmtric

DF1=2*A*W+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);
DF1=DF1/norm(DF1);
W=W-r1*DF1;
W=orth(W);

DF2=(2*(R.*(W'*W-I)).*(W'*W-I))+(2*(R.*(W'*W-I)).*(W'*W-I))'-diag(diag(2*(R.*(W'*W-I)).*(W'*W-I)));
DF2=DF2/norm(DF2);
 %if  Cost2(k)>0.01
     R=R+r2*DF2;
%end

%%regularized

DF10=2*A*W0+2*W0*(R0.*(W0'*W0-I).*R0)'+2*W0*(R0.*(W0'*W0-I).*R0)+p*(W0*W0'*W0-W0);
DF10=DF10/norm(DF10);
W0=W0-r1*DF10;
W0=orth(W0);

%regularized
DF20=(2*(R0.*(W0'*W0-I)).*(W0'*W0-I))+(2*(R0.*(W0'*W0-I)).*(W0'*W0-I))'-diag(diag(2*(R0.*(W0'*W0-I)).*(W0'*W0-I)));
DF20=DF20/norm(DF20);
 %if  Cost2(k)>0.01
     R0=R0+r2*DF20;
%end

DF100=2*A*W00+2*W00*(R00.*(W00'*W00-I).*R00)'+2*W00*(R00.*(W00'*W00-I).*R00)+pp*W00;
DF100=DF100/norm(DF100);
W00=W00-r1*DF100;
W00=orth(W00);
 

DF200=(2*(R00.*(W00'*W00-I)).*(W00'*W00-I))+(2*(R00.*(W00'*W00-I)).*(W00'*W00-I))'-diag(diag(2*(R00.*(W00'*W00-I)).*(W00'*W00-I)));
DF200=DF200/norm(DF200);
 %if  Cost2(k)>0.01
     R00=R00+r2*DF200;
%end
      
      
Cost1(k)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
Cost7(k)=trace(W0'*A*W0)+trace((R0.*(W0'*W0-I))'*(R0.*(W0'*W0-I)));
Cost8(k)=trace(W00'*A*W00)+trace((R00.*(W00'*W00-I))'*(R00.*(W00'*W00-I)));
Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
Cost3(k)=trace(W'*A*W);




%%%%%%%%%%%% diagnal 
DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF3=DF3/norm(DF3);
W2=W2-r12*DF3;
W2=orth(W2);

 
%  DF4=diag(diag(2*R2*W2'*W2*W2'*W2-4*R2*W2'*W2+2*R2));
%  DF4=DF4/norm(DF4);
%   if  Cost2(k)>0.1
%             R2=R2+r22*DF4;
% end
      
      
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

figure(6)
plot(Cost6(1:Iterations),'r-*')

figure(7)
plot(Cost7(1:Iterations),'r-*')

figure(8)
plot(Cost8(1:Iterations),'r-*')
 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


 x1=W0'*AA_tr';
 x2_tr=x1';
x1_te=W0'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 x1=W00'*AA_tr';
 x2_tr=x1';
x1_te=W00'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 x1=W2'*AA_tr';
 x2_tr=x1';
x1_te=W2'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
% 

toc
