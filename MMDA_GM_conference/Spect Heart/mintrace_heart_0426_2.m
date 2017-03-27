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

M=8;
%W=rand(n1,M);
W=randn(n1,M)/2;
 W=orth(W);
 


%B=-W'*S*W; % under the constraint W'W=I, B=-W'*S*W
 
 
 

%while norm(W'*W-eye(M),'fro')>0.01

Cost1=zeros(100,1);
Cost2=zeros(100,1);
Cost3=zeros(100,1);
 Cost4=zeros(100,1);
 
    
 L=100;
 
for k0=1:100000
    
    Grad=-A*W-A'*W+L*(4*W*W'*W-4*W); 
    
    
    Cost3(k0)=norm(Grad);
%     
    if norm(Grad)<0.008
%      W_old=W_old-0.001*Grad;
%    else
         
    W=W-0.0003*Grad;
    else
          W=W-0.00015*Grad;
    end
 
Cost1(k0)=-trace(W'*A*W)+L*trace((W'*W-eye(M))'*(W'*W-eye(M)));

Cost2(k0)=-trace(W'*A*W);

  Trace_SW=trace(W'*SW*W);
 
 Trace_SB=trace(W'*SB*W);
 
  Cost4(k0)=Trace_SW/Trace_SB;
end

 


  
figure(1)
plot(Cost1,'r-*')

  figure(2)

plot(Cost2,'r-*')

 figure(3)

plot(Cost3,'r-*')

  figure(4)

plot(Cost4,'r-*')


% 
% x10=WWW'*AA';
% x20_tr=x10';
% svmStruct0= svmtrain(x20_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
% load('test.mat');
% x10_te=WWW'*fea_te';
% x20_te=x10_te';
% classes = svmclassify(svmStruct0,x20_te);
% nCorrect=sum(classes==lab_te);
% accuracy=nCorrect/length(classes)

figure(5)

x1=W'*AA';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
load('test.mat');
x1_te=W'*fea_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)

% % trace(WWW'*A*WWW)
% trace(W'*A*W)
% 
% figure
%  plot(trace_,'r-*')
%  xlabel(' extracted features ')
% ylabel('The trace ratio  for each  extracted features')