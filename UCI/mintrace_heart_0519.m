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
SB=S_B0/80;
SW=S_W0/80+eye(max(length(S_W0)))*0.000001;
 
 
%[X Y]=eig(SB,SW)
 
 
%v=max(max((Y)));
v=0.5
A=-(SB-v*SW);
M=2;
%W=rand(n1,M);
W=randn(n1,M)/2;

% W=orth(W);

 
 
R=rand(M,M);
R=R+R'
 
Iterations=50000;
 
r1=0.0002;
 
r2=0.0001;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
for k=1:Iterations;
%DF1=2*(SB-v*SW)*W+4*W*(R'*R)*W'*W-4*W*R'*R;
%DF1=2*A*W+4*W*(R'*R)*W'*W-4*W*R'*R;
DF1=2*A*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF1=DF1/norm(DF1);
W=W-r1*DF1;


 
DF2=(2*R*W'*W*W'*W-4*R*W'*W+2*R)+(2*R*W'*W*W'*W-4*R*W'*W+2*R)'-diag(diag(2*R*W'*W*W'*W-4*R*W'*W+2*R));
DF2=DF2/norm(DF2);
 if  Cost2(k)>0.01
            R=R+r2*DF2;
end
      
      
Cost1(k)=trace(W'*A*W)+trace(W'*W*R'*R*W'*W-R'*R*W'*W-W'*W*R'*R+R'*R);  
Cost2(k)=trace(W'*W*R'*R*W'*W-R'*R*W'*W-W'*W*R'*R+R'*R);
Cost3(k)=trace(W'*A*W);
 k 
end
 
figure(1)
plot(Cost1(500:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
 
figure(2)
plot(Cost2(500:Iterations),'r-*')

figure(3)
plot(Cost3(500:Iterations),'r-*')

x1=W'*AA';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
load('test.mat');
x1_te=W'*fea_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)

