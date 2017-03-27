clear all;
clc;

A1=[0.9999, 0.9999; 1.0001, 1.0001]
A2=[0.9998, 1.0001; 1.0001, 0.9999];
Lables=[1;1; 2;2];
AA=[A1;A2];
mean_A1=mean(A1)
mean_A2=mean(A2);
mean_AA=mean(AA);

no_fea=2

S_B=(2*(mean_A1-mean_AA)'*(mean_A1-mean_AA)+2*(mean_A2-mean_AA)'*(mean_A2-mean_AA));
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));

S_W=zeros(no_fea,no_fea);

[i j]=size(A1);


for k0=1:2
        S_W=S_W+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:2
        S_W= S_W+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end


[m1,n1]=size(AA);
SB=S_B/4;
SW=S_W/4;
% E=S_W ;
v=1.79
A=-(SB-v*SW);
M=1;
%W=rand(n1,M);
W=randn(n1,M)/2;

 %W=orth(W);

 
 
R=eye(M);
 
 
Iterations=100;
 
r1=0.02;
 
r2=0.001;
 
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


 
DF2=diag(diag(2*R*W'*W*W'*W-4*R*W'*W+2*R));
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
plot(Cost1(1:Iterations),'r-*')

 
figure(2)
plot(Cost2(1:Iterations),'r-*')

figure(3)
plot(Cost3(1:Iterations),'r-*')

 x1=W'*AA';
 x2=x1';


%predict_label = knnclassify(x2, x2,Lables, 8);
%accuracy = length(find(predict_label ==Lables))/length(Lables)*100

% model= svmtrain2(Lables,x2,'-c 2 -t 2 -g 1');
% [predict_label, accuracy, dec_values]= svmpredict(Lables,x2,model);


%svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','rbf_sigma',0.8,'method','SMO','showplot',true);

 svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','LS'); 
 
classes = svmclassify(svmStruct,x2);
nCorrect=sum(classes==Lables);
accuracy=nCorrect/length(classes)