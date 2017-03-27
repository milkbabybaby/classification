%fea=samples*fea*class 1100*256*10
clear;
clc;
load('semeion_all');
no_fea =256;

   AA_tr=fea_tr;
  AA_te=fea_te;
%  mean_B=mean(B_tr);

    




WW=[];

 Num=65
 
for kk=1:Num
        
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

B=S_B0;
E=S_W0+eye(max(length(S_W0)))*0.000001;


[X Y]=eig(B,E);



[II JJ]=max(max((Y)));

W=X(:,JJ);

if kk==1
W=W/norm(W);

WW=[WW  W];
P_g=WW*pinv(WW);
else

% W=(I-P_g)*W;
W=W/norm(W);
WW=[WW  W];
P_g=WW*pinv(WW);
end

I=diag(ones(no_fea,1));

for  k=1:10
A_tr(:,:,k)=A_tr(:,:,k)*(I-P_g)';
end 
kk
end

%WW=orth(WW);

 x1=WW'*AA_tr';
 x2_tr=x1';
x1_te=WW'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


