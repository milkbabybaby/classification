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
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end

 X=AA_tr';
 [m1,n1]=size(fea);
 M=10
W=rand(n1,M);
I=eye(M);
R=rand(M,M);
R=R+R';
Iterations=400;
  
 a=1;
  
b=1

r1=1;

r2=0.1;

Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);

for k=1:Iterations;

%%%%%% symmtric

DF1=a*(2*W*W'*X*X'*W+2*X*X'*W*W'*W-4*X*X'*W)+b*(2*X*X'*W-4*X*X'*W*W'*W-4*W*W'*X*X'*W+2*W*W'*X*X'*W*W'*W+2*W*W'*W*W'*X*X'*W+2*X*X'*W*W'*W*W'*W)+2*W*(R.*(W'*W-I).*R)'+2*W*(R.*(W'*W-I).*R);
DF1=DF1/norm(DF1);
W=W-r1*DF1;
W=orth(W);

    
      
Cost1(k)=a*trace((W*W'*X-X)'*(W*W'*X-X))+b+trace((W'*W*W'*X-W'*X)'*(W'*W*W'*X-W'*X))+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
Cost3(k)=a*trace((W*W'*X-X)'*(W*W'*X-X))+b+trace((W'*W*W'*X-W'*X)'*(W'*W*W'*X-W'*X));

 k 
end

 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

%  model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
%  [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);
predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


