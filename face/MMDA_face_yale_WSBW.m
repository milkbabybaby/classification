clear;
clc;
load('yale.mat');
no_fea =1600;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];
 for k=1:15
  A_tr(1:6,1:1600,k)=fea((k-1)*11+1:(k-1)*11+6,:);
  B_tr(k,1:1600)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*11+1:(k-1)*11+6)];
  A_te(1:5,1:1600,k)=fea((k-1)*11+7:11*k,:);
  lab_te=[lab_te;gnd((k-1)*11+7:11*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
mean_B=mean(fea);
S_B0=zeros(no_fea,no_fea);
 for k=1:15 
 S_B0=6*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end
% %S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));
%  
S_W0=zeros(no_fea,no_fea);

for k=1:15
    for i=1:6
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end
 
%SW=S_W0/80+eye(max(length(S_W0)))*0.000001;
 
[m1,n1]=size(fea);
SB=S_B0/100000;
SW=(S_W0+eye(max(length(S_W0)))*0.000000000001)/100000;

M=4;
W=rand(n1,M);
%W=randn(n1,M)/2;
W2=rand(n1,M);
R2=eye(M);
 
% W=orth(W);
 
I=eye(M);

R=rand(M,M);
R=R+R'
  
Iterations=8000;
  
 r1=0.02;
  
r2=0.001;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);


U=W'*SB*W-I;
P=R.*U;
T=W2'*SB*W2;

for k=1:Iterations;


DF1=2*SW*W+2*SB*W*(P.*R)'+2*SB*W*(P.*R);
DF1=DF1/norm(DF1);
W=W-r1*DF1;

U=W'*SB*W-I;
P=R.*U;
PP=2*P.*U;

DF2=PP+PP'-diag(diag(PP));
DF2=DF2/norm(DF2);
 %if  Cost2(k)>0.01
     R=R+r2*DF2;
%end
%U=W'*SB*W-I;
P=R.*U;    
      
Cost1(k)=trace(W'*SW*W)+trace(P'*P);  
Cost2(k)=trace(P'*P);
Cost3(k)=trace(W'*SW*W);


%%%%%%%%%%%%

DF3=2*SW*W2+2*SB*W2*R2'*R2*T+2*SB*W2*T*R2'*R2-4*SB*W2*R2'*R2;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF3=DF3/norm(DF3);
W2=W2-r1*DF3;

T=W2'*SB*W2;

 
DF4=diag(diag(2*R2*T*T-4*R2*T+2*R2));
DF4=DF4/norm(DF4);
 %if  Cost2(k)>0.01
            R2=R2+r2*DF4;
%end
      
      
Cost4(k)=trace(W2'*SW*W2)+trace(T*R2'*R2*T-R2'*R2*T-T*R2'*R2+R2'*R2);  
Cost5(k)=trace(T*R2'*R2*T-R2'*R2*T-T*R2'*R2+R2'*R2);
Cost6(k)=trace(W2'*SW*W2);

% DF1=2*SW*W+2*SB*W*(R.*(W'*SB*W-I).*R)'+2*SB*W*(R.*(W'*SB*W-I).*R);
% DF1=DF1/norm(DF1);
% W=W-r1*DF1;
% 
% 
%  
% DF2=(2*(R.*(W'*SB*W-I)).*(W'*SB*W-I))+(2*(R.*(W'*SB*W-I)).*(W'*SB*W-I))'-diag(diag(2*(R.*(W'*SB*W-I)).*(W'*SB*W-I)));
% DF2=DF2/norm(DF2);
%  %if  Cost2(k)>0.01
%      R=R+r2*DF2;
% %end
%       
%       
% Cost1(k)=trace(W'*SW*W)+trace((R.*(W'*SB*W-I))'*(R.*(W'*SB*W-I)));  
% Cost2(k)=trace((R.*(W'*SB*W-I))'*(R.*(W'*SB*W-I)));
% Cost3(k)=trace(W'*SW*W);
% 
% 
% %%%%%%%%%%%%
% DF3=2*SW*W2+2*SB*W2*R2'*R2*W2'*SB*W2+2*SB*W2*W2'*SB*W2*R2'*R2-4*SB*W2*R2'*R2;
% %DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
% DF3=DF3/norm(DF3);
% W2=W2-r1*DF3;
% 
% 
%  
% DF4=diag(diag(2*R2*W2'*SB*W2*W2'*SB*W2-4*R2*W2'*SB*W2+2*R2));
% DF4=DF4/norm(DF4);
%  %if  Cost2(k)>0.01
%             R2=R2+r2*DF4;
% %end
%       
%       
% Cost4(k)=trace(W2'*SW*W2)+trace(W2'*SB*W2*R2'*R2*W2'*SB*W2-R2'*R2*W2'*SB*W2-W2'*SB*W2*R2'*R2+R2'*R2);  
% Cost5(k)=trace(W2'*SB*W2*R2'*R2*W2'*SB*W2-R2'*R2*W2'*SB*W2-W2'*SB*W2*R2'*R2+R2'*R2);
% Cost6(k)=trace(W2'*SW*W2);
 k 
end
 
figure(1)
plot(Cost1(500:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
 
figure(2)
plot(Cost2(500:Iterations),'r-*')

figure(3)
plot(Cost3(500:Iterations),'r-*')

figure(4)
plot(Cost4(500:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
 
figure(5)
plot(Cost5(500:Iterations),'r-*')

figure(6)
plot(Cost6(500:Iterations),'r-*')
 
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

model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
[predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
