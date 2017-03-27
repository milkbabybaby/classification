%fea=samples*fea*class 1100*256*10
clear;
clc;
load('semeion_all');
no_fea =256;

   AA_tr=fea_tr;
  AA_te=fea_te;
ntr=size (AA_tr,1);
nte=size(AA_te,1);


mean_tr=mean(AA_tr);
mean_te=mean(AA_te);

AAA_tr=AA_tr-repmat(mean_tr,ntr,1);
AAA_te=AA_te-repmat(mean_te,nte,1);
% AAA_tr=zscore(AA_tr);
% AAA_te=zscore(AA_te);

AAA0_tr=zscore(AA_tr);
AAA0_te=zscore(AA_te);

% 
% L=AAA_tr*AAA_tr';
% M=2
% [V,D]=e   aig(L);
% W=[];
% 
% [X,I]=sort(diag(D),'descend');
% V=V(:,I);
% 
% for i=1:M  
% %W=[W V(:,i)];
% W=[W V(:,i)/norm(V(:,i))];
% end

% base=AAA_tr'*W;
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


% 
L=AAA_tr'*AAA_tr;

M=80
[V,D]=eig(L);
W=[];

[X,I]=sort(diag(D),'descend');
V=V(:,I);

for i=1:M  
%W=[W V(:,i)];
W=[W V(:,i)/norm(V(:,i))];
end


x1=W'*AAA_tr';
 x2_tr=x1';
x1_te=W'*AAA_te';
x2_te=x1_te';

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


%%%%%LL
LL=AAA0_tr'*AAA0_tr;
[VVV,DDD]=eig(LL);
WW=[];
[XXX,III]=sort(diag(DDD),'descend');
VVV=VVV(:,III);

for i=1:M  
%W=[W V(:,i)];
WW=[WW VVV(:,i)/norm(VVV(:,i))];
end



 xx2_tr=AAA0_tr*WW;
xx2_te=AAA0_te*WW;


predict_label = knnclassify(xx2_te, xx2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100