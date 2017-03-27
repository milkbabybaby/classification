clear all 
clc
A11=[5.1 3.5 1.4 0.2 ;4.9 3.0 1.4 0.2 ;4.7 3.2 1.4 0.2 ; 4.6  3.1  1.5 0.2 ; 5.0 3.6 1.4 0.2;
   5.4 3.9 1.7 0.4 ; 4.6 3.4 1.4 0.3;5.0 3.4 1.5 0.2; 4.9 3.1 1.5 0.1;5.4 3.7 1.5 0.2 ;4.8 3.4  1.6 0.2 ; 
   4.8 3.0 1.4 0.1;.3 3.0 1.1 0.1;4.3 3.0 1.1 0.1;5.8 4.0 1.2 0.2;5.7 4.4 1.5 0.4; 5.4 3.9 1.3 0.4 ;
   5.1 3.5 1.4 0.3 ;5.7 3.8 1.7 0.3 ; 5.1 3.8 1.5 0.3;5.4 3.4 1.7 0.2 ; 5.1 3.7 1.5  0.4; 4.6 3.6 1.0 0.2 ;
   5.1 3.3 1.7 0.5; 4.8 3.4 1.9 0.2 ];  %   第一类学习样本
A22=[7.0 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8 6.2 5.6 5.9 6.1 6.3 6.1 6.4 ;
    3.2 3.2 3.1 2.3 2.8 2.8 3.3 2.4 2.9 2.7 2.0 3.0 2.2 2.9 2.9 3.1 3.0 2.7 2.7 2.5 3.2 2.8 2.5 2.8 2.9 ;
    4.7 4.5 4.9 4.0 4.6 4.5 4.7 3.3 4.6 3.9 3.5 4.2 4.0 4.7 3.6 4.4 4.5 4.1  4.5 3.9 4.8 4.0 4.9 4.7 4.3;
    1.4 1.5 1.5 1.3 1.5 1.3 1.6 1.0 1.3 1.4 1.0 1.5 1.0 1.4 1.3 1.4 1.5 1.0 1.5 1.1 1.8 1.3 1.5 1.2 1.3]'; %   第二类学习样本
A33=[ 6.3 5.8 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7 6.0 6.9 5.6 7.7 6.3 6.7 ;
     3.3 2.7 3.0 2.9 3.0 3.0 2.5 2.8 2.5 3.6 3.2 2.7 3.0 2.5 2.8 3.2 3.0 3.8 2.6 2.2 3.2 2.8 2.8 2.7 3.3;
     6.0 5.1 5.9 5.6 5.8 6.6 4.5 6.3 5.8 6.1 5.1 5.3 5.5 5.0 5.1 5.3 5.5 6.7 6.9 5.0 5.7 4.9 6.7 4.9 5.7 ;
     2.5 1.9 2.1 1.8 2.2 2.1 1.7 1.8 1.8 2.5 2.0 1.9 2.1 2.0 2.4 2.3 1.8 2.2 2.3 1.5 2.3 2.0 2.0 1.8 2.1]';
 A111=[5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0;
     3.0 3.4 3.5 3.4 3.2 3.1 3.4 4.1 4.2 3.1 3.2 3.5 3.1 3.0 3.4 3.5 2.3 3.2 3.5 3.8 3.0 3.8 3.2 3.7 3.3 ;
     1.6 1.6 1.5 1.4 1.6 1.6 1.5 1.5 1.4 1.5 1.2 1.3 1.5 1.3 1.5 1.3 1.3 1.3 1.6 1.9 1.4 1.6 1.4 1.5 1.4 ;
     0.2 0.4 0.2 0.2 0.2 0.2 0.4 0.1 0.2 0.1 0.2 0.2 0.1 0.2 0.2 0.3 0.3 0.2 0.6 0.4 0.3 0.2 0.2 0.2 0.2 ]';
 A222=[6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 ;
     3.0 2.8 3.0 2.9 2.6 2.4 2.4 2.7 2.7 3.0 3.4 3.1 2.3 3.0 2.5 2.6 3.0 2.6 2.3 2.7 3.0 2.9 2.9 2.5 2.8 ;
     4.4 4.8 5.0 4.5 3.5 3.8 3.7 3.9 5.1 4.5 4.5 4.7 4.4 4.1 4.0 4.4 4.6 4.0 3.3 4.2 4.2 4.2 4.3 3.0 4.1 ;
     1.4 1.4 1.7 1.5 1.0 1.1 1.0 1.2 1.6 1.5 1.6 1.5 1.3 1.3 1.3 1.2 1.4 1.2 1.0 1.3 1.2 1.3 1.3 1.1 1.3 ]';
 A333=[7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9;
     3.2 2.8 3.0 2.8 3.0 2.8 3.8 2.8 2.8 2.6 3.0 3.4 3.1 3.0 3.1 3.0 3.1 2.7 3.2 3.3 3.0  2.5 3.0 3.4 3.0;
     6.0 4.8 4.9 5.6 5.8 6.1 6.4 5.6 5.1 5.6 6.1 5.6 5.5 4.8 5.4 5.6 5.1 5.1 5.9 5.7 5.2 5.0 5.2 5.4 5.1
     1.8 1.8 1.8 2.1 1.6 1.9 2.0 2.2 1.5 1.4 2.3 2.4 1.8 1.8 2.1 2.4 2.3 1.9 2.3 2.5 2.3 1.9 2.0 2.3 1.8]';
 
 

A1=[A11; A111];
A2=[A22; A222];
A3=[A33; A333];
AA=[A1;A2;A3]; 
AB=[A1;A2;A3];
  no_fea =  4;
  no_sam = 150;
  no_sam1 = 50;
  no_sam2 = 50;
% 
% A1 = Data(Index_C1,Index_Fea);
% A2 = Data(Index_C2,Index_Fea);
% A3=A3;

mean_AA=mean(AA);
mean_A1=mean(A1);
mean_A2=mean(A2);
 mean_A3=mean(A3);
 

%S_B=(mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA)+(mean_A3-mean_AA)'*(mean_A3-mean_AA);

S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA)+(mean_A3-mean_AA)'*(mean_A3-mean_AA));

S_W=zeros(no_fea,no_fea);
 
[i j]=size(A1);
for k0=1:i
        S_W=S_W+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:i
        S_W= S_W+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end

for k0=1:i
        S_W= S_W+(A3(k0,:)-mean_A3)'*(A3(k0,:)-mean_A3);
end


[m1,n1]=size(AA);
SB=S_B/150;
%SW=S_W/150;
SW=S_W/150+eye(max(length(S_W)))*0.000001;


[X Y]=eig(SB,SW)


v=max(max((Y)));
%v=0.2
A=SB-v*SW;
M=3;

W=eye(n1,M);
% WW=rand(n1,M);
% W=[];
% 
% for i=1:M;
% W=[W WW(:,i)/norm(WW(:,i))];
% end
% W=orth(W);

%B=-W'*S*W; % under the constraint W'W=I, B=-W'*S*W
B=-inv(W'*W)*W'*A*W;
W0=zeros(n1,M);
k=1;

%while norm(W'*W-eye(M),'fro')>0.01
while norm(W-W0,'fro')>0.001 


% while k<4
 i=1;
 W_old=W
 
while 1
    
Grad=2*A'*A*W_old+4*A*W_old*B+2*W_old*B*B'+1000*(3*W_old*W_old'*W_old-2*W_old);
F1=norm(A*W_old+W_old*B,'fro')
%F1=norm(A*W_old+W_old*B,'fro')+1000*norm(W_old'*W_old-eye(M),'fro')
W_new=W_old-0.0001*Grad
%F2=norm(A*W_new+W_new*B,'fro')+1000*norm(W_new'*W_new-eye(M),'fro')
F2=norm(A*W_new+W_new*B,'fro')


% Grad=3*W_old*W_old'*W_old-2*W_old;
% F1=norm(W_old'*W_old-eye(M),'fro')
% W_new=W_old-0.001*Grad
% F2=norm(W_new'*W_new-eye(M),'fro')
%if norm(W_new-W_old,'fro')<0.00000001

%F0=abs(F2-F1)

F0=norm(Grad,'fro')
if  F0<0.001
W_best = W_new
break;
end
W_old=W_new;
i=i+1
end

W_bestorth=GS(W_best);

% W_bestorth=[];
% for i=1:M;
% W_bestorth=[W_bestorth W_best(:,i)/norm(W_best(:,i))]
% end
% W_bestorth=orth(W_bestorth)


W0=W;
W=W_bestorth
%W=W_best;

B=-inv(W'*W)*W'*A*W;

SB_update=W'*SB*W;
SW_update=W'*SW*W;
[X Y]=eig(SB_update,SW_update);
%v0=max(max((Y)));
v0=140;
A=SB-v0*SW;
% for i = 1 :M
% W(:,i) = W(:,i) / norm(W(:,i) );
% end
k=k+1
F3=norm(W-W0,'fro')
end;

x2=AB(1:100,:)*W;
figure(3)
Lables=[ones(50,1); -ones(50,1);];
% model_12= svmtrain2(Lables,x2,'-t 2 -g 1');
% [predict_label, accuracy_x12, dec_values_x2]= svmpredict(Lables,x2,model_12);
 svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','QP','showplot',true); 
 
classes = svmclassify(svmStruct,x2);
nCorrect=sum(classes==Lables);
accuracy_12=nCorrect/length(classes)

Lables=[ones(50,1); -ones(50,1);];
figure(4)
x2=AB(51:150,:)*W;
% 
% model_23= svmtrain2(Lables,x2,'-t 2 -g 1');
% [predict_label, accuracy_x23, dec_values_x2]= svmpredict(Lables,x2,model_23);

 svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','QP','showplot',true); 
 
classes = svmclassify(svmStruct,x2);
nCorrect=sum(classes==Lables);
accuracy_23=nCorrect/length(classes)

Lables=[ones(50,1); -ones(50,1);];
figure(5 )
AA_13=[AB(1:50,:); AB(101:150,:)]; 
x2=AA_13*W;
% model_13= svmtrain2(Lables,x2,'-t 2 -g 1');
% [predict_label, accuracy_x13, dec_values_x2]= svmpredict(Lables,x2,model_13);
% 
%  accuracy=(accuracy_x13+accuracy_x23+ accuracy_x13)/3;

 svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','QP','showplot',true); 
 
classes = svmclassify(svmStruct,x2);
nCorrect=sum(classes==Lables);
accuracy_13=nCorrect/length(classes)


accuracy=(accuracy_13+accuracy_23+ accuracy_13)/3


x2=AB*W;
Lables=[ones(50,1); -ones(50,1);3*ones(50,1);];
model= svmtrain2(Lables,x2,'-t 2  -g 2');
[predict_label, accuracy_x23, dec_values_x2]= svmpredict(Lables,x2,model);