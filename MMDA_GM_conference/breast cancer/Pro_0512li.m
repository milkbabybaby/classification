clear all;
clc;
load('Prognostic0.mat');

 no_fea=31;
 A1=fea(1:151,:);
 A2=fea(152:198,:);
 A1_tr=A1(1:100,:);
 A1_te=A1(101:151,:);
 A2_tr=A2(1:35,:);
 A2_te=A2(36:47,:)
 AA_tr=[A1_tr;A2_tr];
 A_te=[A1_te;A2_te];
 lab_tr=[lab(1:100,:);lab(152:186,:)];
 lab_te=[lab(101:151,:);lab(187:198,:)];
 
WW=[];

 Num=10
 
for k=1:Num
    A_tr=[A1_tr;A2_tr] ;

 mean_A_tr=mean(A_tr);
 
mean_A1_tr=mean(A1_tr);

mean_A2_tr=mean(A2_tr);
 
S_B0=(100*(mean_A1_tr-mean_A_tr)'*(mean_A1_tr-mean_A_tr)+35*(mean_A2_tr-mean_A_tr)'*(mean_A2_tr-mean_A_tr));
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));

S_W0=zeros(no_fea,no_fea);



for k0=1:100
        S_W0=S_W0+(A1_tr(k0,:)-mean_A1_tr)'*(A1_tr(k0,:)-mean_A1_tr);
end


for k0=1:35
        S_W0= S_W0+(A2_tr(k0,:)-mean_A2_tr)'*(A2_tr(k0,:)-mean_A2_tr);
end
[m1,n1]=size(A_tr);
B=S_B0
E=S_W0+eye(max(length(S_W0)))*0.000001;


[X Y]=eig(B,E)

%eigY=[eigY diag(Y)];
%rankE=[rankE rank(E)];

[II JJ]=max(max((Y)));

W=X(:,JJ)

if k==1
W=W/norm(W)
WW=[WW  W]
P_g=WW*pinv(WW);
else

% W=(I-P_g)*W;
W=W/norm(W)
WW=[WW  W]
P_g=WW*pinv(WW);
end

I=diag(ones(no_fea,1));
%  
 A11=((I-P_g)*A1')';
 A22=((I-P_g)*A2')';
% A33=((I-P_g)*A3')';
  
  A1_tr=A11;
  A2_tr=A22;
%    A3=A33;


end

x1=WW'*AA_tr';
x2_tr=x1';
%svmStruct= svmtrain(x2_tr,lab_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
svmStruct= svmtrain(x2_tr,lab_tr,'Kernel_Function','rbf' ,'rbf_sigma',1.4, 'method','QP');
x1_te=WW'*A_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)

%  x11=WW(:,1)'*AA_tr';
% x22=x11';
%   svmStruct_LDA= svmtrain(x22,lab_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
% 
% x11_te=WW(:,1)'*A_te';
% x22_te=x11_te';
% classes = svmclassify(svmStruct_LDA,x22_te);
% nCorrect=sum(classes==lab_te);
% accuracy=nCorrect/length(classes)

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 model= svmtrain2(lab_tr,x2_tr,'-c 1 -t 2 -g 4 -q ');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);
