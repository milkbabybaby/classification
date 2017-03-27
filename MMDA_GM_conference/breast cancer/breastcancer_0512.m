clear all;
clc;
load('Diagnostic.mat');

 no_fea=30;
 A1=fea(1:357,:);
 A2=fea(358:569,:);
 A1_tr=A1(1:150,:);
 A1_te=A1(151:357,:);
 A2_tr=A2(1:100,:);
 A2_te=A2(101:212,:)
 A_tr=[A1_tr;A2_tr];
 A_te=[A1_te;A2_te];
 lab_tr=[lab(1:150,:);lab(358:457,:)];
 lab_te=[lab(151:357,:);lab(458:569,:)];
 
mean_A_tr=mean(A_tr);
 
mean_A1_tr=mean(A1_tr);

mean_A2_tr=mean(A2_tr);
 
S_B0=(150*(mean_A1_tr-mean_A_tr)'*(mean_A1_tr-mean_A_tr)+100*(mean_A2_tr-mean_A_tr)'*(mean_A2_tr-mean_A_tr));
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));

S_W0=zeros(no_fea,no_fea);



for k0=1:150
        S_W0=S_W0+(A1_tr(k0,:)-mean_A1_tr)'*(A1_tr(k0,:)-mean_A1_tr);
end


for k0=1:100
        S_W0= S_W0+(A2_tr(k0,:)-mean_A2_tr)'*(A2_tr(k0,:)-mean_A2_tr);
end 

[m1,n1]=size(A1);
SB=S_B0/100000;
SW=S_W0/100000+eye(max(length(S_W0)))*0.000001;


[X Y]=eig(SB,SW);


v=max(max((Y)));
%v=0.2
A=-(SB-v*SW);
M=1;
W=randn(n1,M);
W=orth(W);
R=eye(M);
 
 
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

Cost1(k)=trace(W'*A*W)+trace(W'*W*R'*R*W'*W-R'*R*W'*W-W'*W*R'*R+R'*R);
 
DF2=diag(diag(2*R*W'*W*W'*W-4*R*W'*W+2*R));
DF2=DF2/norm(DF2);
 if  Cost2(k)>0.01
            R=R+r2*DF2;
end
      
      
   
Cost2(k)=trace(W'*W*R'*R*W'*W-R'*R*W'*W-W'*W*R'*R+R'*R);
Cost3(k)=trace(W'*A*W);
 k 
end
 
figure(1)
plot(Cost1(500:Iterations),'r-*')
 
 
figure(2)
plot(Cost2(500:Iterations),'r-*')

figure(3)
plot(Cost3(500:Iterations),'r-*')

% x1=W'*AA';
% x2=x1';
% plot(x2(1:40,1) ,x2(1:40,2),'r*')   
% hold on
% plot(x2(41:80,1),x2(41:80,2),'bo')
% hold on
% legend('good', 'bad')
%  svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','rbf_sigma',0.8,'method','LS','showplot',true); 
%  
% classes = svmclassify(svmStruct,x2);
% nCorrect=sum(classes==Lables);
% accuracy=nCorrect/length(classes)
x1=W'*A_tr';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,lab_tr,'Kernel_Function','rbf','method','LS','showplot',true); 

x1_te=W'*A_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)


