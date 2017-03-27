%  11 examples per class;  15 classes ; 165 examples in total;
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
  B_tr(k,1:1024)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*11+1:(k-1)*11+tr_num)];
  A_te(1:te_num,1:1024,k)=fea((k-1)*11+tr_num+1:11*k,:);
  lab_te=[lab_te;gnd((k-1)*11+tr_num+1:11*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
 
ntr=size (AA_tr,1);
nte=size(AA_te,1);

mean_B=mean(B_tr);
mean_tr=mean(AA_tr);
mean_te=mean(AA_te);

% AAA_tr=AA_tr-repmat(mean_tr,ntr,1);
% AAA_te=AA_te-repmat(mean_te,nte,1);

AAA_tr=zscore(AA_tr);
AAA_te=zscore(AA_te);
% LL=AAA_tr*AAA_tr';
% M=2
% [VV,DD]=eig(LL);
% WW=[];
% 
% [XX,II]=sort(diag(DD),'descend');
% VV=VV(:,II);
% 
% for i=1:M  
% %W=[W V(:,i)];
% WW=[WW VV(:,i)/norm(VV(:,i))];
% end
% 
% base=AAA_tr'*WW;
% 
% for i=1:M
%     base(:,i)=base(:,i)/norm(base(:,i));
% end 
% 
% x1_tr=AAA_tr*base;
% % 
% % x2_te=AAA_te*base;
% x2_tr=[];
% for i=1:ntr
%  temp=AAA_tr(i,:)*base;
%  x2_tr=[x2_tr;temp]
% end 
% 
% x2_te=AAA_te*base;



% 
L=AAA_tr'*AAA_tr;

M=80
[V,D]=eig(L);
W=[];

[X,I]=sort(diag(D),'descend');
V=V(:,I);

for i=1:M  
% W=[W V(:,i)];
W=[W V(:,i)/norm(V(:,i))];
end

x1=W'*AAA_tr';
 x2_tr=x1';
x1_te=W'*AAA_te';
x2_te=x1_te';

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

toc