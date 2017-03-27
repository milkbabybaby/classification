%  11 examples per class;  15 classes ; 165 examples in total;
close all
clc;
clear;
tic;
load('Yale_Scale_32x32.mat');
no_fea =1024;
class_num=15;
tr_num=7;
te_num=11-tr_num;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];
AAA_tr=[];
AAAA_tr=[];
AAAAA_tr=[];


 for k=1:15
  A_tr(1:tr_num,1:1024,k)=fea((k-1)*11+1:(k-1)*11+tr_num,:);
  B_tr(k,1:1024)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*11+1:(k-1)*11+tr_num)];
  A_te(1:te_num,1:1024,k)=fea((k-1)*11+tr_num+1:11*k,:);
  lab_te=[lab_te;gnd((k-1)*11+tr_num+1:11*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
mean_B=mean(B_tr);


kk=2
p=1;
for j=1:class_num
        [IDX,D]= knnsearch(A_tr(:,:,j),A_tr(:,:,j),'k',kk);
        IDXXX=IDX';
              IDXX(:,:,j)=IDXXX;
        %DD(:,:,j)=D;
end 
for j=1:class_num
    AAA_tr=[];
    C_tr=[];
    DDD_tr=[];
    for i=1:tr_num
        D_tr=A_tr(IDXX(:,i,j),:,j);
        D_tr(1,:)=p*D_tr(1,:);
        DD_tr=sum(D_tr,1)/(p+kk-1);
        DDD_tr=[DDD_tr;DD_tr];
        C_tr=[C_tr; A_tr(IDXX(:,i,j),:,j)];
   AAA_tr=  [AAA_tr; mean(A_tr(IDXX(:,i,j),:,j),1)];
    end 
    AAAA_tr(:,:,j)=AAA_tr;
     CC_tr(:,:,j)=C_tr;
     DDDD_tr(:,:,j)=DDD_tr;
    AAAAA_tr=[AAAAA_tr;AAA_tr];
    BB_tr(j,1:1024)=mean(AAAA_tr(:,:,j));
end 


mean_BB=mean(BB_tr);

S_B0=zeros(no_fea,no_fea);
 for k=1:class_num
% S_B0=tr_num*(BB_tr(k,:)-mean_BB)'*(BB_tr(k,:)-mean_BB)+S_B0;
  S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
%   for i=1:tr_num
%       S_B0=(AAAA_tr(i,:,k)-mean_B)'*(AAAA_tr(i,:,k)-mean_B)+S_B0;
%  end 
 end

S_W0=zeros(no_fea,no_fea);
for k=1:class_num
    for i=1:tr_num
     S_W0=S_W0+(DDDD_tr(i,:,k)-B_tr(k,:))'*(DDDD_tr(i,:,k)-B_tr(k,:));% a-'-m
    % S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
%         for m=1:kk
%          S_W0=S_W0+(CC_tr(kk*(i-1)+m,:,k)-AAAA_tr(i,:,k))'*(CC_tr(kk*(i-1)+m,:,k)-AAAA_tr(i,:,k));% 小的类间距
%          end 
    end
end

[m1,n1]=size(fea);
SB=S_B0; 
SW=S_W0+eye(max(length(S_W0)))*0.000001;
I1=eye(n1);

v=10

%A=SW-v*SB;
A=-(SB-v*SW);
M=20;
W=rand(n1,M);
W2=rand(n1,M);
R2=eye(M);

I=eye(M);
R=rand(M,M);
R=R+R';
  
Iterations=3000;
  
 r1=0.06
  

Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);
Cost5=zeros(Iterations,1);
Cost6=zeros(Iterations,1);

for k=1:Iterations;

DF1=2*A*W;
%DF1=2*(A+2*I1)*W;
DF1=DF1/norm(DF1);
W1=W-r1*(I1-W*W')*DF1;


W=sqrt(trace(W1'*W1)/trace(W1'*W1*W1'*W1))*W1;
      
      
Cost1(k)=trace(W'*A*W);
Cost2(k)=trace((W'*W-I)'*(W'*W-I));  
 k 
end
 
figure(1)
plot(Cost1(1:Iterations),'r-*')
ylabel('The value of cost function');
xlabel('Iteration number');
 
 
figure(2)
plot(Cost2(1:Iterations),'r-*')

 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';


predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
