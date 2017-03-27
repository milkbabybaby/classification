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



v=1/80;


A=(SB-v*SW);

M=6;
%W=rand(n1,M);
W=rand(n1,M);
W=orth(W);
 


%B=-W'*S*W; % under the constraint W'W=I, B=-W'*S*W
B=-inv(W'*W)*W'*A*W;

W0=zeros(n1,M);
k=1;
trace_(k)=trace(W'*A*W);

%while norm(W'*W-eye(M),'fro')>0.01

Cost1=zeros(100,1);
Cost2=zeros(100,1);
Cost3=zeros(100,1);
W_old=orth((rand(n1,M)));
for k1=1:10
    
 
 
for k0=1:20000
    
    Grad=(5*(2*A'*A*W_old-4*A*W_old*B+2*W_old*B*B')+400*(4*W_old*W_old'*W_old-4*W_old));
    Cost3(k0)=norm(Grad);
%     
%   if norm(Grad)<0.15
%      W_old=W_old-0.001*Grad;
%    else
         
    W_old=W_old-0.0002*Grad;
 
%     if norm(Grad)<0.1
%         break
%     end
   %Cost1(k0)=(norm(-A*W_old+W_old*B,'fro'))^2+500*(norm(W_old'*W_old-eye(M),'fro'))^2; 
Cost1(k0)=trace(5*(-A*W_old+W_old*B)'*(-A*W_old+W_old*B))+400*trace((W_old'*W_old-eye(M))'*(W_old'*W_old-eye(M)));
Cost4(k0)=trace((-A*W_old+W_old*B)'*(-A*W_old+W_old*B))+0*trace((W_old'*W_old-eye(M))'*(W_old'*W_old-eye(M)));
end

W=W_old;
W_old=W;
Cost2(k1)=-trace(W'*A*W);
B=pinv(W'*W)*W'*A*W;
end

figure(1)
plot(Cost1,'r-*')

figure(2)

plot(Cost2,'r-*')

 figure(3)

plot(Cost3,'r-*')

figure(4)

plot(Cost4,'r-*')
% x10=WWW'*AA';
% x20_tr=x10';
% svmStruct0= svmtrain(x20_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
% load('test.mat');
% x10_te=WWW'*fea_te';
% x20_te=x10_te';
% classes = svmclassify(svmStruct0,x20_te);
% nCorrect=sum(classes==lab_te);
% accuracy=nCorrect/length(classes)
% 
% 
% x1=W'*AA';
% x2_tr=x1';
% svmStruct= svmtrain(x2_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
% load('test.mat');
% x1_te=W'*fea_te';
% x2_te=x1_te';
% classes = svmclassify(svmStruct,x2_te);
% nCorrect=sum(classes==lab_te);
% accuracy=nCorrect/length(classes)
% 
% trace(WWW'*A*WWW)
% trace(W'*A*W)
% 
% figure
%  plot(trace_,'r-*')
%  xlabel(' extracted features ')
% ylabel('The trace ratio  for each  extracted features')