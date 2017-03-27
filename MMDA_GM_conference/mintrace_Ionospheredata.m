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


v=max(max((Y)));
%v=0.2
A=SB-v*SW;
M=6;
%W=rand(n1,M);
WW=rand(n1,M);
W=[];
for i=1:M;
W=[W WW(:,i)/norm(WW(:,i))];
W=orth(W);
end

%B=-W'*S*W; % under the constraint W'W=I, B=-W'*S*W
B=-inv(W'*W)*W'*A*W;
W0=zeros(n1,M);
k=1;

%while norm(W'*W-eye(M),'fro')>0.01
while  norm(W-W0,'fro')>0.00001 
%while k<3
 i=1;
 W_old=W
 %uGrad=0.1
 uGrad=0.0001;
while 1
    
Grad=2*A'*A*W_old+4*A*W_old*B+2*W_old*B*B'+100*(4*W_old*W_old'*W_old-4*W_old);
F1=norm(A*W_old+W_old*B,'fro')
F10=norm(A*W_old+W_old*B,'fro')+100*norm(W_old'*W_old-eye(M),'fro')
W_new=W_old-uGrad*Grad
F2=norm(A*W_new+W_new*B,'fro')
F20=norm(A*W_new+W_new*B,'fro')+100*norm(W_new'*W_new-eye(M),'fro')



% Grad=3*W_old*W_old'*W_old-2*W_old;
% F1=norm(W_old'*W_old-eye(M),'fro')
% W_new=W_old-0.001*Grad
% F2=norm(W_new'*W_new-eye(M),'fro')
%if norm(W_new-W_old,'fro')<0.00000001
if isnan(F2)
    break;
end

% F0=abs(F2-F1)
% if  F0<0.00001
%if  F2<0.4
F0=norm(Grad,'fro')
% if  F0<0.22
%     uGrad=0.00001;
% end
if F0<0.1
    
W_best = W_new
break;
end

W_old=W_new;
i=i+1


end

%W_bestorth=GS(W_best);

% W_bestorth=[];
% for i=1:M;
% W_bestorth=[W_bestorth W_best(:,i)/norm(W_best(:,i))]
% end
% W_bestorth=orth(W_bestorth);

W0=W;
%W=W_bestorth
W=W_best;

B=-inv(W'*W)*W'*A*W;

SB_update=W'*SB*W;
SW_update=W'*SW*W;
[X Y]=eig(SB_update,SW_update);
%v0=max(max((Y)));
v0=5;
A=SB-v0*SW;
k=k+1
F3=norm(W-W0,'fro')
end;


 x1=W'*AA';
 x2=x1';
plot(x2(1:225,1) ,x2(1:225,2),'r*')   
hold on
plot(x2(226:351,1),x2(226:351,2),'bo')
hold on
legend('good', 'bad')

%predict_label = knnclassify(x2, x2,Lables, 8);
%accuracy = length(find(predict_label ==Lables))/length(Lables)*100

% model= svmtrain2(Lables,x2,'-c 2 -t 2 -g 1');
% [predict_label, accuracy, dec_values]= svmpredict(Lables,x2,model);


%svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','rbf_sigma',0.8,'method','SMO','showplot',true);

 svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','rbf_sigma',0.8,'method','LS','showplot',true); 
 
classes = svmclassify(svmStruct,x2);
nCorrect=sum(classes==Lables);
accuracy=nCorrect/length(classes)