%fea=samples*fea*class 11*1600*15
clear;
clc;
load('yale.mat');
no_fea =1600;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];
rankE=[];
eigY=[];

W=rand(no_fea,1);
W=W/norm(W);



 for k=1:15
  A_tr(1:6,1:1600,k)=fea((k-1)*11+1:(k-1)*11+6,:);
  B_tr(k,1:1600)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*11+1:(k-1)*11+6)];
  A_te(1:5,1:1600,k)=fea((k-1)*11+7:11*k,:);
  lab_te=[lab_te;gnd((k-1)*11+7:11*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
 
 AA_tr0=AA_tr;
 
mean_B=mean(B_tr);

S_B0=zeros(no_fea,no_fea);
 for k=1:15 
 S_B0=6*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end
 
S_W0=zeros(no_fea,no_fea);
for k=1:15
    for i=1:6
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end

 
[m1,n1]=size(fea);
 SB=S_B0;
 SW=S_W0+eye(max(length(S_W0)))*0.000001;

BB=SB;
EE=SW;

BBB=SB;
EEE=SW;

B=SB;
E=SW;


P1=W'*E*W;
P2=W'*B*W;


no_select=4
 
  

WW=[];

traceP=[];

for kk=1:no_select
    
  for k=1:15
      
%   AA_tr=[];
  B_tr(k,1:1600)=mean(A_tr(:,:,k));
%   AA_tr=[AA_tr;A_tr(:,:,k)];
 end
   
mean_B=mean(B_tr);

S_B0=zeros(no_fea,no_fea);
 for k=1:15 
 S_B0=6*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end
 
S_W0=zeros(no_fea,no_fea);

for k=1:15
    for i=1:6
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end
 


B=S_B0;
E=S_W0+eye(max(length(S_W0)))*0.000001;
% E=S_W ;

[X Y]=eig(B,E);


[II JJ]=max(max((Y)));

II

JJ
W=X(:,JJ);
W(1:5)
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

for k=1:15
A_tr(:,:,k)=((I-P_g)*A_tr(:,:,k)')';
end



P1=W'*S_W0*W;
P2=W'*S_B0*W;

PP1=WW'*EEE*WW;
PP2=WW'*BBB*WW;


trace1(kk)=trace(P2)/trace(P1);
trace2(kk)=trace(PP2)/trace(PP1);

end

 x1=WW'*AA_tr0';
 x2_tr=x1';
x1_te=WW'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

figure(1)
 plot(trace1,'r-*')

figure(2)
plot(trace2,'b-*')
% 
% redict_label==lab_te))/length(lab_te)*100
% 
%  x1=W2'*AA_tr';
%  x2_tr=x1';
% x1_te=W2'*AA_te';
% x2_te=x1_te';
% 
% % model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% % [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);
% 
% predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
% accuracy = length(find(predict_label==lab_te))/length(lab_te)*100