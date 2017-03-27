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
 
 
 K=100
d=14
a=0.2
 
 x1=SLLE(AA_tr',K,d,a,tr_num); % d*N
 %x2=maplle(AA_tr', AA_te', K,x1); %d*N
 
 X_tr=AA_tr';
 X_te=AA_te';
 Y=x1;
 
 
[D,N1] = size(X_tr);
[D,N2] = size(X_te);


X1 = sum(X_tr.^2,1);
X2 = sum(X_te.^2,1);
distance = repmat(X2,N1,1)+repmat(X1',1,N2)-2*X_tr'*X_te;


[sorted,index] = sort(distance);
neighborhood = index(1:K,:);



% STEP2: SOLVE FOR RECONSTRUCTION WEIGHTS

if(K>D) 
 
  tol=1e-3; % regularlizer in case constrained fits are ill conditioned
else
  tol=0;
end;
tol=1e-3;
W = zeros(K,N2);
for ii=1:N2
   z = X_tr(:,neighborhood(:,ii))-repmat(X_te(:,ii),1,K); % shift ith pt to origin
   C = z'*z;                                        % local covariance
   C = C + eye(K,K)*tol*trace(C);                   % regularlization (K>D)
   W(:,ii) = C\ones(K,1);                           % solve Cw=1
   W(:,ii) = W(:,ii)/sum(W(:,ii));                  % enforce sum(w)=1
  x2(:,ii)=Y(:,neighborhood(:,ii))*W(:,ii);
end;



 x2_tr=x1';

x2_te=x2';

 model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);
 
  x2_tr=x1';

x2_te=x2';

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
 