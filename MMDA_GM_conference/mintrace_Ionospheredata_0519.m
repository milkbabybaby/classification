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


%v=max(max((Y)));
v=3.5
A=-(SB-v*SW);
M=10;
%W=rand(n1,M);
W=randn(n1,M)/2;

 W=orth(W);

 
 
%R=eye(M);
 R=randn(M,M)
 R=R'+R
 
Iterations=2000;
 
r1=0.0045;
 
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
plot(Cost1(1:Iterations),'r-*')

xlabel('Iteration number','FontName','Arial','FontSize',11);
ylabel('The value of cost function','FontName','Arial','FontSize',11');
 
figure(2)
plot(Cost2(500:Iterations),'r-*')

figure(3)
plot(Cost3(500:Iterations),'r-*')

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