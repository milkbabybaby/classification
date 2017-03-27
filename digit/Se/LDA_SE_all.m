%fea=samples*fea*class 1100*256*10
clear;
clc;
load('semeion_all');
no_fea =256;

   AA_tr=fea_tr;
  AA_te=fea_te;
%  mean_B=mean(B_tr);

    
    for k=1:10
        B_tr(k,1:no_fea)=mean(A_tr(:,:,k));
    end 
mean_B=mean(B_tr);
  
  S_B0=zeros(no_fea,no_fea);
    for k=1:10
      S_B0=100*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
  end

  
  
  S_W0=zeros(no_fea,no_fea);
 for k=1:10
     for i=1:100
        S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
     end
 end

SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;

[V,D]=eig(SB,SW);

[X,I]=sort(diag(D), 'descend');
V=V(:,I);


M=12
W=[];
for i=1:M
W=[W V(:,i)];    
%W=[W V(:,i)/norm(V(:,i))];
end

%W=orth(W);
trace(W'*SW*W)/trace(W'*SB*W)




 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


