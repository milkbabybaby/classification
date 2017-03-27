 % 10 examples per class;  40 classes ; 400 examples in total;
clear;
clc;

tic;

load('ORL_Scale_32x32.mat');
no_fea =1024;
class_num=40;
ex_num=10;
tr_num=8;
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
 
 
 K=50
d=70
a=0.2
 



x1=SLLE(AA_tr',K,d,a,tr_num); % d*N
 x2=maplle(AA_tr', AA_te', K,x1); %d*N
 

 x2_tr=x1';

x2_te=x2';

 model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);
 
  x2_tr=x1';

x2_te=x2';

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100