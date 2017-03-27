clear;
clc;
load('yale.mat');
no_fea =1600;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];
 for k=1:15
  A_tr(1:6,1:1600,k)=fea((k-1)*11+1:(k-1)*11+6,:);
  B_tr(k,1:1600)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*11+1:(k-1)*11+6)];
  A_te(1:5,1:1600,k)=fea((k-1)*11+7:11*k,:);
  lab_te=[lab_te;gnd((k-1)*11+7:11*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
mean_B=mean(B_tr);
S_B0=zeros(no_fea,no_fea);
 for k=1:15 
 S_B0=6*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end
% %S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));
%  
S_W0=zeros(no_fea,no_fea);

for k=1:15
    for i=1:6
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end
 
%SW=S_W0/80+eye(max(length(S_W0)))*0.000001;
 
[m1,n1]=size(fea);
SB=S_B0/1000;
SW=(S_W0+eye(max(length(S_W0)))*0.000000000001)/1000;



M=30;
I=eye(M);
W2=rand(n1,M);
W2=rand(n1,M);

 
 
U=W'*SW*W;
P=W'*SB*W;

A=-(SB-v*SW);

Iterations=8000;
  
 r1=0.002;
  
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
    
 L=100;
 
 
 Trace_SW=trace(W'*SW*W);
 
 Trace_SB=trace(W'*SB*W);
 
  R0=Trace_SW/Trace_SB;
  
for k0=1:100000
    
 Trace_SW=trace(W'*SW*W);
 Trace_SB=trace(W'*SB*W);
Grad=(2*SW*W*Trace_SB-2*SB*W*Trace_SW+L*(Trace_SB)^2*(4*W*W'*W-4*W))/(Trace_SB)^2;
    
 W=W-0.0003*Grad;
 
    


Cost1(k0)=Trace_SW/Trace_SB+L*trace((W'*W-I)'*(W'*W-I));

Cost2=trace((W'*W-eye(M))'*(W'*W-eye(M)));

Cost2(k0)=(Trace_SW/Trace_SB);
    
Cost4(k0)=norm(Grad);


   Grad2=2*A*W2+L*(4*W2*W2'*W2-4*W2); 
    

%     
    if norm(Grad2)<0.008
%      W_old=W_old-0.001*Grad;
%    else
         
    W2=W2-0.0003*Grad2;
    else
          W2=W2-0.00015*Grad2;
    end
 
Cost5(k0)=trace(W2'*A*W2)+L*trace((W2'*W2-I)'*(W2'*W2-I));
Cost6(k0)=trace(W2'*A*W2);
Cost7(k0)=trace((W2'*W2-I)'*(W2'*W2-I));
Cost8(k0)=norm(Grad2);


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
 
figure(4)
plot(Cost4,'r-*')
 
 
figure(5)
plot(Cost5,'r-*')

figure(6)
plot(Cost6,'r-*')

figure(7)
plot(Cost7,'r-*')

figure(8)
plot(Cost8,'r-*')
 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
[predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 x1=W2'*AA_tr';
 x2_tr=x1';
x1_te=W2'*AA_te';
x2_te=x1_te';

model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
[predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100