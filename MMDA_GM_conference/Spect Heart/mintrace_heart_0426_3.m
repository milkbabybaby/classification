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
SB=S_B0;
SW=S_W0;


%[X Y]=eig(SB,SW)



 


 

M=8;
%W=rand(n1,M);
W=randn(n1,M)/2;
W=orth(W);
 


%B=-W'*S*W; % under the constraint W'W=I, B=-W'*S*W
 
 
 

%while norm(W'*W-eye(M),'fro')>0.01

Cost1=zeros(100,1);
Cost2=zeros(100,1);
Cost3=zeros(100,1);
 
 
    
 L=100;
 
 
 Trace_SW=trace(W'*SW*W)
 
 Trace_SB=trace(W'*SB*W)
 
  R0=Trace_SW/Trace_SB
for k0=1:100000
    
 Trace_SW=trace(W'*SW*W);
 Trace_SB=trace(W'*SB*W);
 
    Grad=(2*SW*W*Trace_SB-2*SB*W*Trace_SW+L*(Trace_SB)^2*(4*W*W'*W-4*W))/(Trace_SB)^2;
    
     W=W-0.0003*Grad;
 
    
    
    Cost3(k0)=norm(Grad);
 
         
Cost1(k0)=Trace_SW/Trace_SB+L*trace((W'*W-eye(M))'*(W'*W-eye(M)));

Cost2(k0)=(Trace_SW/Trace_SB);
end
 


% 
%  
%  
figure(1)
plot(Cost1,'r-*')

  figure(2)

plot(Cost2,'r-*')

 figure(3)

plot(Cost3,'r-*')
% 
%  
% 
% % 
% % x10=WWW'*AA';
% % x20_tr=x10';
% % svmStruct0= svmtrain(x20_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
% % load('test.mat');
% % x10_te=WWW'*fea_te';
% % x20_te=x10_te';
% % classes = svmclassify(svmStruct0,x20_te);
% % nCorrect=sum(classes==lab_te);
% % accuracy=nCorrect/length(classes)
% 
% 
x1=W'*AA';
x2_tr=x1';
svmStruct= svmtrain(x2_tr,Lables_tr,'Kernel_Function','rbf','method','LS','showplot',true); 
load('test.mat');
x1_te=W'*fea_te';
x2_te=x1_te';
classes = svmclassify(svmStruct,x2_te);
nCorrect=sum(classes==lab_te);
accuracy=nCorrect/length(classes)
