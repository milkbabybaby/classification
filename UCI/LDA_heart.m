clear;
clc;
load('train.mat');
Lables_tr=lab;
no_fea =  22;
 A1=fea(1:40,:);
 A2=fea(41:80,:);
 AA=[A1;A2] ;
mean_AA=mean(AA);
 
mean_A1=mean(A1);

mean_A2=mean(A2);
 
S_B0=(40*(mean_A1-mean_AA)'*(mean_A1-mean_AA)+126*(mean_A2-mean_AA)'*(mean_A2-mean_AA));
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));

S_W0=zeros(no_fea,no_fea);



for k0=1:40
        S_W0=S_W0+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:40
        S_W0= S_W0+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end 

[m1,n1]=size(AA);
SB=S_B0/80;
SW=S_W0/80+eye(max(length(S_W0)))*0.000001;


[X Y]=eig(SB,SW)


[II JJ]=max(max((Y)));

W=X(:,JJ)

 W=W/norm(W)



x1=W'*AA';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
load('test.mat');
x1_te=W'*fea_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)

%    0.6738