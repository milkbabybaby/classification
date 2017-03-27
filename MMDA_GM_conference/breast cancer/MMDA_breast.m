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


%
v=0.00001
%A=SW-v*SB;
A=-(SB-v*SW);
M=20;
W=rand(n1,M);
W2=rand(n1,M);
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';
  
Iterations=400;
  
 r1=0.1;
  
r2=1

 r12=0.1;
  
r22=1;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);
Cost5=zeros(Iterations,1);
Cost6=zeros(Iterations,1);
for k=1:Iterations;

%%%%%% symmtric

DF1=2*A*W+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);
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


%%%%%%%%%%%% diagnal 
DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF3=DF3/norm(DF3);
W2=W2-r12*DF3;
W2=orth(W2);

%  
% DF4=diag(diag(2*R2*W2'*W2*W2'*W2-4*R2*W2'*W2+2*R2));
% DF4=DF4/norm(DF4);
%  %if  Cost2(k)>0.01
%             R2=R2+r22*DF4;
% %end
      
      
Cost4(k)=trace(W2'*A*W2)+trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);  
Cost5(k)=trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);
Cost6(k)=trace(W2'*A*W2);
 k 
end
 
figure(1)
plot(Cost1(1:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
%  
% figure(2)
% plot(Cost2(1:Iterations),'r-*')
% 
% figure(3)
% plot(Cost3(1:Iterations),'r-*')

figure(4)
plot(Cost4(1:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
%  
%  
% figure(5)
% plot(Cost5(1:Iterations),'r-*')
% 
% figure(6)
% plot(Cost6(1:Iterations),'r-*')
%  
%  x1=W'*AA';
%  x2_tr=x1';
%  
% load('test.mat');
% x1_te=W'*fea_te';
% x2_te=x1_te';
% 
%  model= svmtrain2(Lables_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
%  [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);


x1=W'*A_tr';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,lab_tr,'Kernel_Function','rbf','method','LS','showplot',true); 

x1_te=W'*A_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)
% 

% predict_label = knnclassify(x2_te, x2_tr,Lables_tr, 1);
% accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


 x1=W2'*A_tr';
 x2_tr=x1';

x1_te=W'*A_te';
x2_te=x1_te';
% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

% predict_label = knnclassify(x2_te, x2_tr,Lables_tr, 1);
% accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

x1=W2'*A_tr';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,lab_tr,'Kernel_Function','rbf','method','LS','showplot',true); 

x1_te=W'*A_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)


