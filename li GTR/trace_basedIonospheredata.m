clear;
clc;
load('Ionospheredata.mat');
AA=sortrows(A,35);
A1=AA(1:225,1:34);
A2=AA(226:351,1:34);
Lables=AA(:,35);

no_fea =  34;
no_sam = 351;
no_sam1 = 225;
no_sam1 = 126;

no_select=34;
 
  

WW=[];

traceP=[];
AA0=[A1;A2]; 

for k=1:2
 AA=[A1;A2] ;
mean_AA=mean(AA);
 
mean_A1=mean(A1);

mean_A2=mean(A2);



S_B=225*(mean_A1-mean_AA)'*(mean_A1-mean_AA)+126*(mean_A2-mean_AA)'*(mean_A2-mean_AA);
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));

S_W=zeros(no_fea,no_fea);

[i j]=size(A1);


for k0=1:225
        S_W=S_W+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:126
        S_W= S_W+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end



B=S_B;
E=S_W+eye(max(length(S_W)))*0.000001;
% E=S_W ;

[X Y]=eig(B,E)

%eigY=[eigY diag(Y)];
%rankE=[rankE rank(E)];

[II JJ]=max(max((Y)));

W=X(:,JJ)

if k==1
W=W/norm(W)
WW=[WW  W]
P_g=WW*pinv(WW);
else

% W=(I-P_g)*W;
W=W/norm(W)
WW=[WW  W]
P_g=WW*pinv(WW);
end

%WW=WW/norm(WW)
P1=W'*S_W*W;
P2=W'*S_B*W;



%trace_(k)=trace(P2)/trace(P1);
%trace1_(k)=trace(PP2)/trace(PP1);

%traceP=[traceP ; trace(P2) trace(P1)  trace(PP2) trace(PP1)] 

I=diag(ones(no_fea,1));
%  
 A11=((I-P_g)*A1')';
 A22=((I-P_g)*A2')';
% A33=((I-P_g)*A3')';
  
  A1=A11;
  A2=A22;
%    A3=A33;


U22110=W'*AA';       % 第一二类样本在二维上的投影
%U2211=U211;
x0=U22110(1,:);         % 二维投影的第一个坐标   
%y0=U22110(2,:);      % 二维投影的第二个坐标   
W2=W;
 

subplot(2,1,k) 
plot(x0(1:225) ,'r*')          % 作出二维上的投影图
hold on
plot(x0(226:351),'bo')
hold on
end


 x1=WW'*AA0';
 x2=x1';
plot(x2(1:225,1) ,x2(1:225,2),'r*')   
hold on
plot(x2(226:351,1),x2(226:351,2),'bo')
hold on
legend('good', 'bad')

%predict_label = knnclassify(x2, x2,Lables, 8);
%accuracy = length(find(predict_label ==Lables))/length(Lables)*100

model= svmtrain2(Lables,x2,'-c 2 -t 2 -g 1');
[predict_label, accuracy, dec_values]= svmpredict2(Lables,x2,model);


%svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','rbf_sigma',0.8,'method','SMO','showplot',true);

%  svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','LS','showplot',true); 
%  
%classes = svmclassify(svmStruct,x2);
% nCorrect=sum(classes==Lables);
% accuracy=nCorrect/length(classes)