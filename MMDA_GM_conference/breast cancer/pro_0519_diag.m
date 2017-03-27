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
SB=S_B0/500000;
SW=S_W0/500000;
[X Y]=eig(SB,SW);


%v=max(max((Y)));
v=0.01;
A=-(SB-v*SW);
M=5;
W=randn(n1,M);
W=orth(W);
 R=eye(M);
 
 
Iterations=2000;
 
r1=0.004;
 
r2=0.0002;
 
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

%W=orth(W);

DF2=diag(diag(2*R*W'*W*W'*W-4*R*W'*W+2*R));
DF2=DF2/norm(DF2);
 %if  Cost2(k)>0.0001
R=R+r2*DF2;
%end

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


x1=W'*A_tr';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,lab_tr,'Kernel_Function','rbf','rbf_sigma', 1, 'method','LS'); 

x1_te=W'*A_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 3 -g 30 -q ');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);
