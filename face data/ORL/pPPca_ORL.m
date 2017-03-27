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
 

options=[];
options.ReducedDim=20;
[eigvector,eigvalue] = PCA(AA_tr,20);

M=75

for i=1:M
W=[];
W=[W,eigvector(:,i)];
end 
 x2_tr=AA_tr*W;

x2_te=AA_te*W;
predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100