clear;
clc;
load('USPS_sort.mat');
no_fea =256;
mean_1=mean(train_1);
mean_2=mean(train_2);
mean_3=mean(train_3);
mean_4=mean(train_4);
mean_5=mean(train_5);
mean_6=mean(train_6);
mean_7=mean(train_7);
mean_8=mean(train_8);
mean_9=mean(train_9);
mean_10=mean(train_10);
mean_tr=mean(fea_tr);

S_B0=1194*(mean_1-mean_tr)'*(mean_1-mean_tr)+1005*(mean_2-mean_tr)'*(mean_2-mean_tr)+731*(mean_3-mean_tr)'*(mean_3-mean_tr)+658*(mean_4-mean_tr)'*(mean_4-mean_tr)+652*(mean_5-mean_tr)'*(mean_5-mean_tr)+556*(mean_6-mean_tr)'*(mean_6-mean_tr)+664*(mean_7-mean_tr)'*(mean_7-mean_tr)+645*(mean_8-mean_tr)'*(mean_8-mean_tr)+542*(mean_9-mean_tr)'*(mean_9-mean_tr)+644*(mean_10-mean_tr)'*(mean_10-mean_tr);

S_W0=zeros(no_fea,no_fea);
for i=1:1194
    S_W0=S_W0+(train_1(i,:)-mean_1)'*(train_1(i,:)-mean_1);
end

for i=1:1005
    S_W0=S_W0+(train_2(i,:)-mean_2)'*(train_2(i,:)-mean_2);
end

for i=1:731
    S_W0=S_W0+(train_3(i,:)-mean_3)'*(train_3(i,:)-mean_3);
end

for i=1:658
    S_W0=S_W0+(train_4(i,:)-mean_4)'*(train_4(i,:)-mean_4);
end

for i=1:652
    S_W0=S_W0+(train_5(i,:)-mean_5)'*(train_5(i,:)-mean_5);
end

for i=1:556
    S_W0=S_W0+(train_6(i,:)-mean_6)'*(train_6(i,:)-mean_6);
end

for i=1:664
    S_W0=S_W0+(train_7(i,:)-mean_7)'*(train_7(i,:)-mean_7);
end

for i=1:645
    S_W0=S_W0+(train_8(i,:)-mean_8)'*(train_8(i,:)-mean_8);
end

for i=1:542
    S_W0=S_W0+(train_9(i,:)-mean_9)'*(train_9(i,:)-mean_9);
end

for i=1:644
    S_W0=S_W0+(train_10(i,:)-mean_10)'*(train_10(i,:)-mean_10);
end

 
[m1,n1]=size(fea_tr);
SB=S_B0/7291;
SW=(S_W0)/7291;
%SW=(S_W0+eye(max(length(S_W0)))*0.000001)/7291;
%  
% %[X Y]=eig(SB,SW)
%  
%  
% %v=max(max((Y)));
v=2

%A=SW-v*SB;
A=-(SB-v*SW);
M=4;
W=rand(n1,M);
W2=rand(n1,M);
R2=eye(M);
I=eye(M);
II=eye(n1);
R=rand(M,M);
R=5*(R+R');
  
Iterations=500;
  
 r1=1;
  
r2=0.01;

 r12=0.4;
  
r22=0.002;
 
% Cost1=zeros(Iterations,1);
% Cost2=zeros(Iterations,1);
% Cost3=zeros(Iterations,1);
% Cost4=zeros(Iterations,1);
% Cost5=zeros(Iterations,1);
% Cost6=zeros(Iterations,1);
NN=n1*M;
MM=zeros(n1,n1,M,M);
 H=zeros(n1,n1,M,M);

W1=W;

WW=reshape(W,NN,1);  %reshape X into a vector 

Iterations=400;
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);

for ii=1:Iterations 
    
  Cost1(ii)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));   
 Cost2(ii)=trace(W1'*A*W1)+trace((R.*(W1'*W1-I))'*(R.*(W1'*W1-I))); 
  
RR=R.*R;
P111=R.*(W'*W-I).*R;
for i=1:n1
    for j= 1:M
        for m =1:M
            for n=1:n1
                for k=1:M
                   MM(i,n,m,j)=W(i,k)*RR(j,k)*I(j,m)*W(n,k)+MM(i,n,m,j);
                end 
                    
               H(i,n,m,j)=I(j,m)*A(i,n)+I(j,m)*A(n,i)+4*(II(i,n)*P111(j,m)+MM(i,n,m,j)+W(i,m)*RR(j,m)*W(n,j));
               
            end
        end
    end
end


HH=[];
for j=1:M;
HH=[HH; H(:,:,:,j)]; % combine three order tensor in the i direction, then the first "block row" is j=1, the second "block row" is j=2 
end

HHH=[];
for m=1:M;
HHH=[HHH HH(:,:,m)]; %combine matrix in the n direction, then the first " block column" is m=1, the second " block column" is m=2 
end%  Newton method
    
    DF=2*A*W+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);  
    
    DF_vec=reshape(DF,NN,1); %reshape first order derivative into a vetor 
    %WW=WW-inv(HHH)*DF_vec/norm(DF_vec);
  WW=WW-3*pinv(HHH+0.5*eye(length(HHH)))*DF_vec/(norm(pinv(HHH+0.5*eye(length(HHH)))*DF_vec));
   
    W=reshape(WW,n1,M);  % reshape vector XX into a matrix X
   
    
    
    % Gradient  method 
DF1=2*A*W1+2*W1*(R.*(W1'*W1-I).*R)'+2*W1*(R.*(W1'*W1-I).*R);
DF1=DF1/norm(DF1);
W1=W1-r1*DF1;
%W=orth(W);    

 ii
 
end 

figure(1)
plot(Cost1(1:Iterations),'r-*')

figure(2)
plot(Cost2(1:Iterations),'r-*')
    