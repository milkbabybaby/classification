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
 A_tr=[A1_tr;A2_tr];
 A_te=[A1_te;A2_te];
 lab_tr=[lab(1:100,:);lab(152:186,:)];
 lab_te=[lab(101:151,:);lab(187:198,:)];
 
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

[m1,n1]=size(A1);
SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;




[X Y]=eig(SB,SW)



[II JJ]=max(max((Y)));

W=X(:,JJ);


x1=W'*A_tr';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,lab_tr,'Kernel_Function','rbf','method','LS','showplot',true); 

x1_te=W'*A_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)

 %0.6508

