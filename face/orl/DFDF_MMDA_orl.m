%  10 examples per class;  40 classes ; 400 examples in total fea=10*2567*40;
clear;
clc;
load('orl.mat');
no_fea =2576;

tr_num=5;
te_num=10-tr_num;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];

ss=ones(1,tr_num)';

sss=ones(1,te_num)';


A_tr=fea(1:tr_num,:,:);
A_te=fea(tr_num+1:10,:,:);


for k=1:40
   B_tr(k,1:no_fea)=mean(A_tr(:,:,k));
   lab_tr=[lab_tr;k*ss];
   lab_te=[lab_te;k*sss];
    AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
end
  mean_B=mean(B_tr);
  
  S_B0=zeros(no_fea,no_fea);
    for k=1:40
      S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
  end

  
  S_W0=zeros(no_fea,no_fea);
 for k=1:40
     for i=1:tr_num
        S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
     end
 end
    

%SW=S_W0/80+eye(max(length(S_W0)))*0.000001;
 
[m1,n1,p1]=size(fea);
SB=S_B0/10000;
SW=(S_W0+eye(max(length(S_W0)))*0.0001)/10000;
%  
%  
% %[X Y]=eig(SB,SW)
%  
%  
% %v=max(max((Y)));
v=0.05
A=SW-v*SB;
%A=-(SB-v*SW);
M=50;
W=rand(n1,M);
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';
  
Iterations=800;

 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);
Cost5=zeros(Iterations,1);
Cost6=zeros(Iterations,1);

NN=n1*M;
M=zeros(n1,n1,M,M);
 MM=zeros(n1,n1,M,M);

W1=W;

WW=reshape(W,NN,1)  %reshape X into a vector 

Iterations=40;
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);

for i=1:Iterations 
    
  Cost1(i)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));   
 Cost1(i)=trace(W1'*A*W1)+trace((R.*(W1'*W1-I))'*(R.*(W1'*W1-I))); 
  
RR=R.*R;


for i=1:n1
    for j= 1:M
        for m =1:M
            for n=1:n1
                for k=1:M
                   MM(i,n,m,j)=W(i,k)*RR(j,k)*I(j,m)*W(n,k)+MM(i,n,m,j);
                end 
                    
               M(i,n,m,j)=I(j,m)*A(i,n)+I(j,m)*A(n,i)+ MM(i,n,m,j)+W(i,m)*RR(j,m)*W(n,j);
               
            end
        end
    end
end


QQ=[];
for j=1:M;
QQ=[QQ; M(:,:,:,j)] % combine three order tensor in the i direction, then the first "block row" is j=1, the second "block row" is j=2 
end

QQQ=[];
for m=1:M;
QQQ=[QQQ QQ(:,:,m)] %combine matrix in the n direction, then the first " block column" is m=1, the second " block column" is m=2 
end%  Newton method
    
    P=2*A*W+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);  
    
    PP=reshape(P,NN,1); %reshape first order derivative into a vetor 
    WW=WW-inv(QQQ)*PP;  % update XX
    W=reshape(WW,N,MM);  % reshape vector XX into a matrix X
   
    
    
    % Gradient  method 
DF1=2*A*W1+2*W1*(R.*(W1'*W1-I).*R)'+2*W1*(R.*(W1'*W1-I).*R);
DF1=DF1/norm(DF1);
W1=W1-r1*DF1;
%W=orth(W);    
 
end 

figure(1)
plot(Cost1(1:Iterations),'r-*')

figure(2)
plot(Cost2(1:Iterations),'r-*')
    
