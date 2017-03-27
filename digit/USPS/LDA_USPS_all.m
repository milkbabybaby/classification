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
%  mean_B=mean(B_tr);

    
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

SB=S_B0;
SW=S_W0+eye(max(length(S_W0)));

[V,D]=eig(SB,SW);

[X,I]=sort(diag(D), 'descend');
V=V(:,I);


M=2
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


