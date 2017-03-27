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
SB=S_B0/1000;
SW=S_W0/1000+eye(max(length(S_W0)))*0.000001;
 
 
[X Y]=eig(SB,SW);
 
 
%v=max(max((Y)));
v=5
A=-(SB-v*SW);
M=8;
%W=rand(n1,M);
W=randn(n1,M)/2;

% W=orth(W);

 I=eye(M);
 
R=rand(M,M);
R=R+R'
 
Iterations=3000;
 
r1=0.032;
 
r2=0.001;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
for k=1:Iterations;



DF1=2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);
DF1=DF1/norm(DF1);
W=W-r1*DF1;
W=orth(W);

 
DF2=(2*(R.*(W'*W-I)).*(W'*W-I))+(2*(R.*(W'*W-I)).*(W'*W-I))'-diag(diag(2*(R.*(W'*W-I)).*(W'*W-I)));
DF2=DF2/norm(DF2);
 %if  Cost2(k)>0.01
     R=R+r2*DF2;
%end
      
      
Cost1(k)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
Cost3(k)=trace(W'*A*W);



 k 
end
 
figure(1)
plot(Cost1(1:Iterations),'r-*')

xlabel('Iteration number','FontName','Arial','FontSize',11);
ylabel('The value of cost function','FontName','Arial','FontSize',11');
 
 
figure(2)
plot(Cost2(1:Iterations),'r-*')

figure(3)
plot(Cost3(1:Iterations),'r-*')

x1=W'*AA';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
load('test.mat');
x1_te=W'*fea_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)
