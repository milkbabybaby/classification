clear all;
clc;
load('Ionospheredata.mat');
AA=sortrows(A,35);
A1=AA(1:225,1:34);
A2=AA(226:351,1:34);
Lables=AA(:,35);

no_fea =  34;
no_sam = 351;
no_sam1 = 225;
no_sam1 = 126;

 AA=[A1;A2] ;
mean_AA=mean(AA);
 
mean_A1=mean(A1);

mean_A2=mean(A2);



S_B=(225*(mean_A1-mean_AA)'*(mean_A1-mean_AA)+126*(mean_A2-mean_AA)'*(mean_A2-mean_AA));
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));

S_W=zeros(no_fea,no_fea);

[i j]=size(A1);


for k0=1:225
        S_W=S_W+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:126
        S_W= S_W+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end


[m1,n1]=size(AA);
SB=S_B/351;
SW=S_W/351+eye(max(length(S_W)))*0.000001;
% E=S_W ;

[X Y]=eig(SB,SW)


%
v=1.3
%A=SW-v*SB;
A=-(SB-v*SW);
M=2;
W=rand(n1,M);
W2=rand(n1,M);
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';
  
Iterations=300;
  
 r1=0.1;
  
r2=0.1

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
%W=W/norm(W);
W=orth(W);

 
DF2=(2*(R.*(W'*W-I)).*(W'*W-I))+(2*(R.*(W'*W-I)).*(W'*W-I))'-diag(diag(2*(R.*(W'*W-I)).*(W'*W-I)));
DF2=DF2/norm(DF2);
 if  Cost2(k)>0.01
     R=R+r2*DF2;
end
      
      
Cost1(k)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
Cost3(k)=trace(W'*A*W);


%%%%%%%%%%%% diagnal 
DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF3=DF3/norm(DF3);
W2=W2-r12*DF3;
%W2=orth(W2);
 
DF4=diag(diag(2*R2*W2'*W2*W2'*W2-4*R2*W2'*W2+2*R2));
DF4=DF4/norm(DF4);
 if  Cost2(k)>0.01
            R2=R2+r22*DF4;
end
      
      
Cost4(k)=trace(W2'*A*W2)+trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);  
Cost5(k)=trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);
Cost6(k)=trace(W2'*A*W2);
 k 
end
 
figure(1)
plot(Cost1(1:Iterations),'r-*')

ylabel('The value of cost function');
xlabel('Iteration number');
 

figure(4)
plot(Cost4(1:Iterations),'r-*')

x11=W'*A1';
x12=W'*A2';
 figure(12)
plot(x11(1,:),x11(2,:),'g*')
hold on
plot(x12(1,:),x12(2,:),'r+')
ylabel('The coordinate of the first extracted feature');
xlabel('The coordinate of the second extracted feature');
legend('1','0')

 x1=W'*AA';
 x2=x1';
 
 svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','LS','showplot',true); 
 
classes = svmclassify(svmStruct,x2);
nCorrect=sum(classes==Lables);
accuracy=nCorrect/length(classes)


% 
%  predict_label = knnclassify(x2, x2,Lables, 1);
% accuracy = length(find(predict_label==Lables))/length(Lables)*100



% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

% predict_label = knnclassify(x2_te, x2_tr,Lables_tr, 1);
% accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 x1=W2'*AA';
 x2=x1';
svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','LS'); 
classes = svmclassify(svmStruct,x2);
nCorrect=sum(classes==Lables);
accuracy=nCorrect/length(classes)
