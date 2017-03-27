%  64=35+29
close all
clc;
clear;
tic;
load('dbworld_1.mat');
no_fea =3721;
tr_num=5;
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

%  
%  

v=12
%A=SW-v*SB;
A=-(SB-v*SW);
M=80;
W=rand(n1,M);
W2=rand(n1,M);
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';
  
Iterations=400;
  
 r1=0.4
  
r2=0.1

 r12=0.4
  
r22=1;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);
Cost5=zeros(Iterations,1);
Cost6=zeros(Iterations,1);
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
      
      
Cost1(k)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
Cost3(k)=trace(W'*A*W);


%%%%%%%%%%%% diagnal 
DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF3=DF3/norm(DF3);
W2=W2-r12*DF3;
W2=orth(W2);

%  
% DF4=diag(diag(2*R2*W2'*W2*W2'*W2-4*R2*W2'*W2+2*R2));
% DF4=DF4/norm(DF4);
%  %if  Cost2(k)>0.01
%             R2=R2+r22*DF4;
% %end
      
      
Cost4(k)=trace(W2'*A*W2)+trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);  
Cost5(k)=trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);
Cost6(k)=trace(W2'*A*W2);
 k 
end
 
figure(1)
plot(Cost1(1:Iterations),'r-*')
ylabel('The value of cost function');
xlabel('Iteration number');

 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

 model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

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
 

