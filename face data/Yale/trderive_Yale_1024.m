
%  11 examples per class;  15 classes ; 165 examples in total;%7 trainning
clear;
clc;

tic;

load('Yale_Scale_32x32.mat');
no_fea =1024;

tr_num=7;
te_num=11-tr_num;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];



 for k=1:15
  A_tr(1:tr_num,1:1024,k)=fea((k-1)*11+1:(k-1)*11+tr_num,:);
  B_tr(k,1:1024)=mean(A_tr(:,:,k),1);
  lab_tr=[lab_tr;gnd((k-1)*11+1:(k-1)*11+tr_num)];
  A_te(1:te_num,1:1024,k)=fea((k-1)*11+tr_num+1:11*k,:);
  lab_te=[lab_te;gnd((k-1)*11+tr_num+1:11*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
mean_B=mean(B_tr,1);

S_B0=zeros(no_fea,no_fea);
 for k=1:15
 S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end

S_W0=zeros(no_fea,no_fea);
for k=1:15
    for i=1:tr_num
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end


[m1,n1]=size(fea);
SB=S_B0; 
SW=S_W0+eye(max(length(S_W0)))*0.000001;




M=10;
%W=rand(n1,M);
W=randn(n1,M)/2;
W=orth(W);

W1=W;


L=3
  %Q=zeros(n1,n1,M,M);

  Iterations=3000;
  

Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);


for k0=1:Iterations
    
 
   
    TraceSW=trace(W1'*SW*W1);
 TraceSB=trace(W1'*SB*W1);

Grad=(2*SW*W1*TraceSB-2*SB*W1*TraceSW)/(TraceSB^2)+L*(4*W1*W1'*W1-4*W1);
Grad=Grad/norm(Grad); 
 
   W1=W1-0.04*Grad;

   
 Cost3(k0)=TraceSW/TraceSB+L*trace((W1'*W1-eye(M))'*(W1'*W1-eye(M)));

Cost4(k0)=(TraceSW/TraceSB);


    
   
   %  W1=orth(W1);
k0
end


 
 x1=W1'*AA_tr';
 x2_tr=x1';
x1_te=W1'*AA_te';
x2_te=x1_te';

 model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100



