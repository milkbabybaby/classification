%  11 examples per class;  15 classes ; 165 examples in total;clear;
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
for j=1:class_num
        [IDX,D]= knnsearch(A_tr(:,:,j),A_tr(:,:,j),'k',kk);
        IDXXX=IDX';
              IDXX(:,:,j)=IDXXX;
        %DD(:,:,j)=D;
end 

for j=1:class_num
    AAA_tr=[];
    for i=1:tr_num
   AAA_tr=  [AAA_tr; mean(A_tr(IDXX(:,i,j),:,j),1)];
    end 
    AAAA_tr(:,:,j)=AAA_tr;
    AAAAA_tr=[AAAAA_tr;AAA_tr];
    BB_tr(j,1:1024)=mean(AAAA_tr(:,:,j));
end 


mean_BB=mean(BB_tr);

% S_B0=zeros(no_fea,no_fea);
%  for k=1:15
%  S_B0=tr_num*(BB_tr(k,:)-mean_BB)'*(BB_tr(k,:)-mean_BB)+S_B0;
%  end
% 
% S_W0=zeros(no_fea,no_fea);
% for k=1:15
%     for i=1:tr_num
% %      S_W0=S_W0+(AAAA_tr(i,:,k)-BB_tr(k,:))'*(AAAA_tr(i,:,k)-BB_tr(k,:));
%        S_W0=S_W0+(A_tr(i,:,k)-BB_tr(k,:))'*(A_tr(i,:,k)-BB_tr(k,:));
%     end
% end

S_B0=zeros(no_fea,no_fea);
 for k=1:15
 S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end

S_W0=zeros(no_fea,no_fea);
for k=1:15
    for i=1:tr_num
       S_W0=S_W0+(AAAA_tr(i,:,k)-B_tr(k,:))'*(AAAA_tr(i,:,k)-B_tr(k,:));
    end
end

    
[m1,n1]=size(fea);
SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;


M=11
[V,D]=eig(SB,SW);
W=[];

[X,I]=sort(diag(D),'descend');
V=V(:,I);

for i=1:M
    
%W=[W V(:,i)];
W=[W V(:,i)/norm(V(:,i))];
end

trace(W'*SW*W)/trace(W'*SB*W)
 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

toc
