%  11 examples per class;  15 classes ; 165 examples in total;
clear;
clc;

tic;

load('Yale_Scale_32x32.mat');
no_fea =1024;

tr_num=7;
te_num=11-tr_num;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];



 for k=1:15
  A_tr(1:tr_num,1:1024,k)=fea((k-1)*11+1:(k-1)*11+tr_num,:);
  B_tr(k,1:1024)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*11+1:(k-1)*11+tr_num)];
  A_te(1:te_num,1:1024,k)=fea((k-1)*11+tr_num+1:11*k,:);
  lab_te=[lab_te;gnd((k-1)*11+tr_num+1:11*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
mean_B=mean(B_tr);

S_B0=zeros(no_fea,no_fea);
 for k=1:15
 S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end

S_W0=zeros(no_fea,no_fea);
for k=1:15
    for i=1:tr_num
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end


[m1,n1]=size(fea);
SB=S_B0; 
SW=S_W0+eye(max(length(S_W0)))*0.000001;

%  
%  

v=3.6
%A=SW-v*SB;
A=-(SB-v*SW);

M=4;
NN=n1*M;

W=rand(n1,M);
W1=W;
WW=reshape(W,NN,1);



I=eye(M);
II=eye(n1)
I1=eye(NN);

R=rand(M,M);
R=R+R';
RR=R.*R;
R2=eye(M);



 r1=0.4;
  
r2=0.1;

 r12=0.4;
  
r22=1;
 



 H=zeros(n1,n1,M,M);



Iterations=100;
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);

for ii=1:Iterations 
  

P111=R.*(W'*W-I).*R;
for i=1:n1
    for j= 1:M
        for m =1:M
            for n=1:n1
                
                MM=0;
                for k=1:M
                   MM=W(i,k)*RR(k,j)*I(m,j)*W(n,k)+MM;
                end 
                    
               H(i,n,m,j)=2*I(j,m)*A(i,n)+4*(II(i,n)*P111(j,m)+MM+W(i,m)*RR(m,j)*W(n,j));
               
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
end

%  Newton method
    
    DF=2*A*W+4*W*(R.*(W'*W-I).*R);
    
    DF_vec=reshape(DF,NN,1); 
    WW=WW-inv(HHH+10*I1)*DF_vec/norm(inv(HHH+10*I1)*DF_vec);
   %WW=WW-3*pinv(HHH+0.5*eye(length(HHH)))*DF_vec/(norm(pinv(HHH+0.5*eye(length(HHH)))*DF_vec));
   
    W=reshape(WW,n1,M);  % reshape vector XX into a matrix X
   
    
    
    % Gradient  method 
DF1=2*A*W1+2*W1*(R.*(W1'*W1-I).*R);
DF1=DF1/norm(DF1);
W1=W1-r1*DF1;
W1=orth(W1);    

Cost1(ii)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));   
Cost2(ii)=trace(W1'*A*W1)+trace((R.*(W1'*W1-I))'*(R.*(W1'*W1-I))); 


 ii
 
end 

 
figure(1)
plot(Cost1(1:Iterations),'r-*')
ylabel('The value of cost function');
xlabel('Iteration number');
 
 
figure(2)
plot(Cost2(1:Iterations),'r-*')


 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

 model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 x1=W1'*AA_tr';
 x2_tr=x1';
x1_te=W1'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
% 
