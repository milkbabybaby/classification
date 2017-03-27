%trace(W'*SW*W)/trace(W'*SB*W);
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
mean_B=mean(fea);
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



M=60;
I=eye(M);
W=rand(n1,M);
W2=rand(n1,M);
R=rand(M,M);
R=R+R';
R2=eye(M);

 
 
U=trace(W'*SW*W);
P=trace(W'*SB*W);
Q=W'*W-I;
T=R.*Q;

U2=trace(W2'*SW*W2);
P2=trace(W2'*SB*W2);
Q2=W2'*W2;
T2=R2'*R2;




 R=rand(M,M);
 R=R+R'
  
Iterations=8000;
  
 r1=0.04;
  
r2=0.002;

 r12=0.04;
  
r22=0.004;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
for k=1:Iterations;



DF1=(2*SW*W*P-2*SB*W*U)/(P^2)+2*W*(T.*R)'+2*W*(T.*R);
DF1=DF1/norm(DF1);
W=W-r1*DF1;

U=trace(W'*SW*W);
P=trace(W'*SB*W);
Q=W'*W-I;
T=R.*Q;
QQ=2*T.*Q;


%DF2=(2*(R.*(W'*W-I)).*(W'*W-I))+(2*(R.*(W'*W-I)).*(W'*W-I))'-diag(diag(2*(R.*(W'*W-I)).*(W'*W-I))); 
DF2=QQ+QQ'-diag(diag(QQ));
DF2=DF2/norm(DF2);
 if  Cost2(k)>0.02
     R=R+r2*DF2;

     
T=R.*Q;
QQ=2*T.*Q;
 end
      
Cost1(k)=U/P+trace(T'*T);  
Cost2(k)=trace(T'*T);
Cost3(k)=U/P;


%%%%%%%%%%%%
%DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
DF3=(2*SW*W2*P2-2*SB*W2*U2)/(P2^2)+2*W2*T2*Q2+2*W2*Q2*T2-4*W2*T2;
DF3=DF3/norm(DF3);
W2=W2-r12*DF3;



U2=trace(W2'*SW*W2);
P2=trace(W2'*SB*W2);
Q2=W2'*W2;


 
DF4=diag(diag(2*R2*Q2*Q2-4*R2*W2'*W2+2*R2));
DF4=DF4/norm(DF4);
 if  Cost2(k)>0.02
            R2=R2+r22*DF4;

 end 
T2=R2'*R2;
    
      
Cost4(k)=U2/P2+trace(Q2*T2*Q2-T2*Q2-Q2*T2+T2);  
%Cost5(k)=trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);
Cost5(k)=trace(Q2*T2*Q2-T2*Q2-Q2*T2+T2);
Cost6(k)=U2/P2;
 k 
end
 
figure(1)
plot(Cost1(500:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
 
figure(2)
plot(Cost2(500:Iterations),'r-*')

figure(3)
plot(Cost3(500:Iterations),'r-*')

figure(4)
plot(Cost4(500:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
 
figure(5)
plot(Cost5(500:Iterations),'r-*')

figure(6)
plot(Cost6(500:Iterations),'r-*')
 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

%model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
%[predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 x1=W2'*AA_tr';
 x2_tr=x1';
x1_te=W2'*AA_te';
x2_te=x1_te';

%model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
%[predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


