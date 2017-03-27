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



v=1
A=SB-v*SW;
M=6;
%W=rand(n1,M);
WW=rand(n1,M);
W=[];
for i=1:M;
W=[W WW(:,i)/norm(WW(:,i))];
W=orth(W);
end

WWW=W;
%B=-W'*S*W; % under the constraint W'W=I, B=-W'*S*W
B=-inv(W'*W)*W'*A*W;
W0=zeros(n1,M);
k=1;
trace_(k)=trace(W'*A*W);

%while norm(W'*W-eye(M),'fro')>0.01
while  norm(W-W0,'fro')>0.0001
%while k<3
 i=1;
 W_old=W
 
 %uGrad=0.1
 uGrad=0.002;
while 1
    
Grad=2*A'*A*W_old+4*A*W_old*B+2*W_old*B*B'+100*(4*W_old*W_old'*W_old-4*W_old);
F1=norm(A*W_old+W_old*B,'fro')
F10=norm(A*W_old+W_old*B,'fro')+100*norm(W_old'*W_old-eye(M),'fro')
W_new=W_old-uGrad*Grad
F2=norm(A*W_new+W_new*B,'fro')
F20=norm(A*W_new+W_new*B,'fro')+100*norm(W_new'*W_new-eye(M),'fro')


if isnan(F2)
    break;
end

F0=norm(Grad,'fro')

if F0<0.1
    
W_best = W_new
break;
end

W_old=W_new;
i=i+1

end

W0=W;

W=W_best;

B=-inv(W'*W)*W'*A*W;

SB_update=W'*SB*W;
SW_update=W'*SW*W;
[X Y]=eig(SB_update,SW_update);
%v0=max(max((Y)));
%v0=11;
%A=SB-v0*SW;

k=k+1
trace_(k)=trace(W'*A*W);
F3=norm(W-W0,'fro')
end;


x10=WWW'*AA';
x20_tr=x10';
svmStruct0= svmtrain(x20_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
load('test.mat');
x10_te=WWW'*fea_te';
x20_te=x10_te';
classes = svmclassify(svmStruct0,x20_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)


x1=W'*AA';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
load('test.mat');
x1_te=W'*fea_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)

trace(WWW'*A*WWW)
trace(W'*A*W)

figure
 plot(trace_,'r-*')
 xlabel(' extracted features ')
ylabel('The trace ratio  for each  extracted features')