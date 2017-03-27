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
SB=S_B0/100000;
SW=S_W0/100000+eye(max(length(S_W0)))*0.000001;


%v=max(max((Y)));
v=0.5;
A=SB-v*SW;
M=4;

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

%while norm(W'*W-eye(M),'fro')>0.01
while  norm(W-W0,'fro')>0.000001 
%while k<3
 i=1;
 W_old=W
 %uGrad=0.1
 uGrad=0.000001;
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
k=k+1
F3=norm(W-W0,'fro')
end;

 x10_tr=WWW'*A_tr';
 x20_tr=x10_tr';
 svmStruct0= svmtrain(x20_tr,lab_tr,'Kernel_Function','rbf','method','LS','showplot',true); 

x10_te=WWW'*A_te';
x20_te=x10_te';


classes = svmclassify(svmStruct0,x20_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)
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


%trace(WWW'*SB*WWW)-v0*trace(WWW'*SW*WWW)
trace(WWW'*A*WWW)
trace(W'*A*W)