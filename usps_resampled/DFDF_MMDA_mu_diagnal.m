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

v=2.2

%A=SW-v*SB;
A=-(SB-v*SW);
M=4;
W=rand(n1,M);
W2=rand(n1,M);
R=10*eye(M);
I=eye(M);
II=eye(n1);
 
Iterations=500;
  
 r1=1;

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

Iterations=100;
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);

for ii=1:Iterations 
    
 Cost1(ii)=trace(W'*A*W)+trace((R*(W'*W-I))'*(R*(W'*W-I)));   
 Cost2(ii)=trace(W1'*A*W1)+trace((R*(W1'*W1-I))'*(R*(W1'*W1-I))); 
  
P112=W'*W*R'*R;
P121=W;
P122=W*R'*R;
P131=W*W';
P132=R'*R;
P212=R'*R*W'*W;
P221=W*R'*R;
P222=W;
P231=W*R'*R*W';
P311=R'*R;

for i=1:n1
    for j= 1:M
        for m =1:M
            for n=1:n1

               H(i,n,m,j)=I(j,m)*A(i,n)+I(j,m)*A(n,i)+2*(II(i,n)*P112(m,j)+P121(i,m)*P122(n,j)+P131(i,n)*P132(m,j)+II(i,n)*P212(m,j)+P221(i,m)*P222(n,j)+P231(i,n)*I(m,j))-4*II(i,n)*P311(m,j);
                   
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
    

    DF=2*A*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;  
    
    DF_vec=reshape(DF,NN,1); %reshape first order derivative into a vetor 
    %WW=WW-inv(HHH)*DF_vec/norm(DF_vec);
     if Cost1(ii)>100
  WW=WW-pinv(HHH+0.5*eye(length(HHH)))*DF_vec/(norm(pinv(HHH+0.5*eye(length(HHH)))*DF_vec));
    else 
 WW=WW-pinv(HHH+10*eye(length(HHH)))*DF_vec;
    end 
    W=reshape(WW,n1,M);  % reshape vector XX into a matrix X
   
    
    
    % Gradient  method 
DF1=2*A*W1+2*W1*(R'*R)*W1'*W1+2*W1*W1'*W1*(R'*R)-4*W1*R'*R;
DF1=DF1/norm(DF1);
if Cost2(ii)>100
W1=W1-r1*DF1;
else
    W1=W1-0.5*DF1;
end 
%W=orth(W);    

 ii
 
end 

figure(1)
plot(Cost1(1:Iterations),'r-*')

figure(2)
plot(Cost2(1:Iterations),'r-*')

 x1=W'*fea_tr';
 x2_tr=x1';
x1_te=W'*fea_te';
x2_te=x1_te';


predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


 x1=W1'*fea_tr';
 x2_tr=x1';
x1_te=W1'*fea_te';
x2_te=x1_te';

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
