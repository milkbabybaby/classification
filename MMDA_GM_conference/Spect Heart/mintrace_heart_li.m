clear;
clc;
load('train.mat');
Lables_tr=lab;
no_fea = 22;
A1=fea(1:40,:);
A2=fea(41:80,:);
AA0=[A1;A2];
 
 

WW=[];

 Num=20
 
for k=1:Num
    AA=[A1;A2] ;
mean_AA=mean(AA);
 
mean_A1=mean(A1);
 
mean_A2=mean(A2);
 
S_B0=(40*(mean_A1-mean_AA)'*(mean_A1-mean_AA)+40*(mean_A2-mean_AA)'*(mean_A2-mean_AA));
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));
 
S_W0=zeros(no_fea,no_fea);
 
 
 
for k0=1:40
        S_W0=S_W0+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end
 
 
for k0=1:40
        S_W0= S_W0+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end
 
[m1,n1]=size(AA);
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
  
  A1=A11;
  A2=A22;
%    A3=A33;


end


x1=WW'*AA0';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
load('test.mat');
x1_te=WW'*fea_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)

 x11=WW(:,1)'*AA0';
x22=x11';
  svmStruct_LDA= svmtrain(x22,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
 load('test.mat');
x11_te=WW(:,1)'*fea_te';
x22_te=x11_te';
classes = svmclassify(svmStruct_LDA,x22_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)
 