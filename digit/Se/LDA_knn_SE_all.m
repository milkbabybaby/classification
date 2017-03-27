%fea=samples*fea*class 1100*256*10
clear;
clc;
load('semeion_all');
no_fea =256;
class_num=10;
tr_num=100;

   AA_tr=fea_tr;
  AA_te=fea_te;
  
AAA_tr=[];
AAAA_tr=[];
AAAAA_tr=[];



 for k=1:class_num
   B_tr(k,1:no_fea)=mean(A_tr(:,:,k));
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
    BB_tr(j,1:no_fea)=mean(AAAA_tr(:,:,j));
end 


mean_BB=mean(BB_tr);

S_B0=zeros(no_fea,no_fea);
 for k=1:class_num
 S_B0=tr_num*(BB_tr(k,:)-mean_BB)'*(BB_tr(k,:)-mean_BB)+S_B0;
 end

S_W0=zeros(no_fea,no_fea);
for k=1:class_num
    for i=1:tr_num
  %S_W0=S_W0+(AAAA_tr(i,:,k)-BB_tr(k,:))'*(AAAA_tr(i,:,k)-BB_tr(k,:));
 S_W0=S_W0+(A_tr(i,:,k)-BB_tr(k,:))'*(A_tr(i,:,k)-BB_tr(k,:));
    end
end

% 
% S_B0=zeros(no_fea,no_fea);
%  for k=1:class_num
%  S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
%  end
% 
% S_W0=zeros(no_fea,no_fea);
% for k=1:class_num
%     for i=1:tr_num
%        S_W0=S_W0+(AAAA_tr(i,:,k)-B_tr(k,:))'*(AAAA_tr(i,:,k)-B_tr(k,:));
%     end
% end



SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;

[V,D]=eig(SB,SW);

[X,I]=sort(diag(D), 'descend');
V=V(:,I);


M=9
W=[];
for i=1:M
%W=[W V(:,i)];    
W=[W V(:,i)/norm(V(:,i))];
end

trace(W'*SW*W)/trace(W'*SB*W)




 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
