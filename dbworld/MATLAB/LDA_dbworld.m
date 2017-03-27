%  64=35+29
close all
clc;
clear;
tic;
load('dbworld.mat');
no_fea =242;
tr_num=25;
class_num=2
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];
AAA_tr=[];
AAAA_tr=[];
AAAAA_tr=[];



  A_tr(:,:,1)=A0(1:tr_num,:);
  
  A_tr(:,:,2)=A1(1:tr_num,:);
  
  
  A0_te=A0(tr_num+1:35,:)
  
  A1_te=A1(tr_num+1:29,:)
  AA_tr=[A_tr(:,:,1);A_tr(:,:,2)];
  
   AA_te=[A0_te;A1_te];
  lab_tr=[0*ones(tr_num,1);ones(tr_num,1)];
  lab_te=[0*ones(35-tr_num,1);ones(29-tr_num,1)];
  B_tr(1,:)=mean(A_tr(:,:,1),1);
  B_tr(2,:)=mean(A_tr(:,:,2),1);

mean_B=mean(B_tr);


S_B0=zeros(no_fea,no_fea);
 for k=1:2
 S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end

S_W0=zeros(no_fea,no_fea);
for k=1:2
    for i=1:tr_num
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end


[m1,n1]=size(fea);
SB=S_B0; 
SW=S_W0+eye(max(length(S_W0)))*0.000001;

M=1
[V,D]=eig(SB,SW);
W=[];

[X,I]=sort(diag(D),'descend');
V=V(:,I);

for i=1:M
    
%W=[W V(:,i)];
W=[W V(:,i)/norm(V(:,i))];
end

trace(W'*SW*W)/trace(W'*SB*W)
 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

