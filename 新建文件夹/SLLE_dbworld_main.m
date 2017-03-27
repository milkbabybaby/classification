%  64=35+29
close all
clc;
clear;
tic;
load('dbworld.mat');
no_fea =242;
tr_num=20;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];

  A_tr(:,:,1)=A0(1:tr_num,:);
  
  A_tr(:,:,2)=A1(1:tr_num,:);
  
  
  A0_te=A0(tr_num+1:35,:)
  
  A1_te=A1(tr_num+1:29,:)
  AA_tr=[A_tr(:,:,1);A_tr(:,:,2)];
  
   AA_te=[A0_te;A1_te];
  lab_tr=[0*ones(tr_num,1);ones(tr_num,1)];
  lab_te=[0*ones(35-tr_num,1);ones(29-tr_num,1)];

  
  
  

 K=8
d=6
a=0.1

 
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
 
    
    

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

