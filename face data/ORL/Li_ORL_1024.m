%  10 examples per class;  40 classes ; 400 examples in total;
clc;
clear;
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
 
AA_tr0=AA_tr;



WW=[];

 Num=2
 
for kk=1:Num
    
    
  for k=1:class_num
  B_tr(k,1:1024)=mean(A_tr(:,:,k));
  end
     
 mean_B=mean(B_tr);
 
 S_B0=zeros(no_fea,no_fea);
 for k=1:class_num
 S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end
% %S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));
%  
S_W0=zeros(no_fea,no_fea);

for k=1:class_num
    for i=1:tr_num
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end
 

B=S_B0;
E=S_W0+eye(max(length(S_W0)))*0.000001;


[X Y]=eig(B,E);



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

I=diag(ones(no_fea,1));

for  k=1:class_num
A_tr(:,:,k)=A_tr(:,:,k)*(I-P_g)';
end 
kk
end



 x1=WW'*AA_tr';
 x2_tr=x1';
x1_te=WW'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


