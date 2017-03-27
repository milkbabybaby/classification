%fea=samples*fea*class 1100*256*10
clear;
clc;
load('semeion_all');
no_fea =256;
class_num=10;
tr_num=100;

 
 
 K=20
d=70
a=0.2
 

   AA_tr=fea_tr;
  AA_te=fea_te;

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
 



