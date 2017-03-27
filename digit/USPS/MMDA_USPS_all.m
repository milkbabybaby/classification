%fea=samples*fea*class 1100*256*10
clear;
clc;
load('USPS.mat');
no_fea =256;
tr_num=800;
te_num=1100-tr_num;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];

ss=ones(1,tr_num)';

sss=ones(1,te_num)';


A_tr=fea(1:tr_num,:,:);
A_te=fea(tr_num+1:1100,:,:);


for k=1:10
   %B_tr(k,1:no_fea)=mean(A_tr(:,:,k));
   lab_tr=[lab_tr;k*ss];
   lab_te=[lab_te;k*sss];
   AA_tr=[AA_tr;A_tr(:,:,k)];% form a matrix
  AA_te=[AA_te;A_te(:,:,k)];
end


    for k=1:10
        B_tr(k,1:no_fea)=mean(A_tr(:,:,k));
    end 
          mean_B=mean(B_tr);
  
  S_B0=zeros(no_fea,no_fea);
    for k=1:10
      S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
  end

  
  
  S_W0=zeros(no_fea,no_fea);
 for k=1:10
     for i=1:tr_num
        S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
     end
 end


[m1,n1,p1]=size(fea);
SB=S_B0;
SW=(S_W0+eye(max(length(S_W0)))*0.0001);
%  
%  
% %[X Y]=eig(SB,SW)
%  
%  
 %v=max(max((Y)));
v=0.01
%A=SW-v*SB;
A=-(SB-v*SW);
M=9;
W=rand(n1,M);
W2=rand(n1,M);
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';
  
Iterations=4000;
  
 r1=0.5;
  
r2=0.01;

 r12=0.2;
  
r22=1;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);
Cost5=zeros(Iterations,1);
Cost6=zeros(Iterations,1);
for k=1:Iterations;

%%%%%% symmtric

% DF1=2*A*W+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);
% DF1=DF1/norm(DF1);
% W=W-r1*DF1;
% %W=orth(W); 
% 
%  
% DF2=(2*(R.*(W'*W-I)).*(W'*W-I))+(2*(R.*(W'*W-I)).*(W'*W-I))'-diag(diag(2*(R.*(W'*W-I)).*(W'*W-I)));
% DF2=DF2/norm(DF2);
%  %if  Cost2(k)>0.01
%      R=R+r2*DF2;
% %end
%      
%       
% Cost1(k)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
% Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
% Cost3(k)=trace(W'*A*W);


%%%%%%%%%%%% diagnal 
DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF3=DF3/norm(DF3);
W2=W2-r12*DF3;
%W2=orth(W2);

 
DF4=diag(diag(2*R2*W2'*W2*W2'*W2-4*R2*W2'*W2+2*R2));
DF4=DF4/norm(DF4);
 %if  Cost2(k)>0.01
            R2=R2+r22*DF4;
%end
      
      
Cost4(k)=trace(W2'*A*W2)+trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);  
Cost5(k)=trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);
Cost6(k)=trace(W2'*A*W2);
 k 
end
 
% figure(1)
% plot(Cost1(1:Iterations),'r-*')
% ylabel('The value of cost function');
% xlabel('Iteration number');
%  
%  
% figure(2)
% plot(Cost2(1:Iterations),'r-*')
% 
% figure(3)
% plot(Cost3(1:Iterations),'r-*')

% figure(4)
% plot(Cost4(1:Iterations),'r-*')
% %ylabel('The value of cost function');
% %xlabel('Iterations');
%  
%  
% figure(5)
% plot(Cost5(1:Iterations),'r-*')
% 
% figure(6)
% plot(Cost6(1:Iterations),'r-*')
%  
%  x1=W'*AA_tr';
%  x2_tr=x1';
%  
% 
%  
%  
% x1_te=W'*AA_te';
% x2_te=x1_te';
% 
%  model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);
% 
% predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
% accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 x1=W2'*AA_tr';
 x2_tr=x1';
x1_te=W2'*AA_te';
x2_te=x1_te';

model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
[predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
% 

