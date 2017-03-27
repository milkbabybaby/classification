%  72examples per class;  20 classes ; 1440 examples in total;
clear;
clc;

tic;

load('COIL20.mat');
no_fea =1024;
class_num=20;
ex_num=72;
tr_num=36;
te_num=72-tr_num;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];



 for k=1:class_num
  A_tr(1:tr_num,1:1024,k)=fea((k-1)*ex_num+1:(k-1)*ex_num+tr_num,:);
  B_tr(k,1:1024)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*ex_num+1:(k-1)*ex_num+tr_num)];
  A_te(1:te_num,1:1024,k)=fea((k-1)*ex_num+tr_num+1:ex_num*k,:);
  lab_te=[lab_te;gnd((k-1)*ex_num+tr_num+1:ex_num*k)];
 end
mean_B=mean(B_tr);


de_value=100;
MM=floor(no_fea/de_value);
n1=no_fea;
M=no_fea;
for mm=1:MM-1
    


S_B0=zeros(n1,n1);
 for k=1:class_num
 S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end

S_W0=zeros(n1,n1);
for k=1:class_num
    for i=1:tr_num
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end


SB=S_B0; 
SW=S_W0+eye(max(length(S_W0)))*0.000001;

v=4
%A=SW-v*SB;
A=-(SB-v*SW);
   
M=M-de_value;
W=rand(n1,M);
W2=rand(n1,M);
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';

Iterations=400;

 r1=0.4;
  
r2=1

 r12=0.4;
  
r22=1;
 
 
for kk=1:Iterations;

%%%%%% symmtric

DF1=2*A*W+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);
DF1=DF1/norm(DF1);
W=W-r1*DF1;
W=orth(W);

 
DF2=(2*(R.*(W'*W-I)).*(W'*W-I))+(2*(R.*(W'*W-I)).*(W'*W-I))'-diag(diag(2*(R.*(W'*W-I)).*(W'*W-I)));
DF2=DF2/norm(DF2);
 %if  Cost2(k)>0.01
     R=R+r2*DF2;
%end



% %%%%%%%%%%%% diagnal 
% DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
% %DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
% DF3=DF3/norm(DF3);
% W2=W2-r12*DF3;
% W2=orth(W2);

kk
end


for k=1:class_num
   G_tr(:,:,k)=A_tr(:,:,k)*W;
   G_te(:,:,k)=A_te(:,:,k)*W;
  H_tr(k,:)=mean(G_tr(:,:,k));
end 
mean_H=mean(H_tr);

clear A_tr A_te B_tr mean_B
A_tr=G_tr;
A_te=G_te;
B_tr=H_tr;
mean_B=mean_H;
clear G_tr G_te H_tr mean_H

n1=M
mm


end

AA_tr=[];
AA_te=[];
 for k=1:class_num
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end

S_B0=zeros(n1,n1);
 for k=1:class_num
 S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
 end

S_W0=zeros(n1,n1);
for k=1:class_num
    for i=1:tr_num
       S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
    end
end



SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;

v=4
A=-(SB-v*SW);
M=60;
W=rand(n1,M);
W2=rand(n1,M);
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';
  
Iterations=400;
  
 r1=0.4;
  
r2=1

 r12=0.4;
  
r22=1;
 
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);
Cost5=zeros(Iterations,1);
Cost6=zeros(Iterations,1);
for k=1:Iterations;

%%%%%% symmtric

DF1=2*A*W+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);
DF1=DF1/norm(DF1);
W=W-r1*DF1;
W=orth(W);

 
DF2=(2*(R.*(W'*W-I)).*(W'*W-I))+(2*(R.*(W'*W-I)).*(W'*W-I))'-diag(diag(2*(R.*(W'*W-I)).*(W'*W-I)));
DF2=DF2/norm(DF2);
 %if  Cost2(k)>0.01
     R=R+r2*DF2;
%end
      
      
Cost1(k)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
Cost3(k)=trace(W'*A*W);

 k 
end

figure(1)
plot(Cost1(1:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
 
figure(2)
plot(Cost2(1:Iterations),'r-*')

figure(3)
plot(Cost3(1:Iterations),'r-*')

 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

%  model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
%  [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);
predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


