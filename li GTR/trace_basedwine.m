clear;
clc;
%format short
A= load ('data.txt');
AA=A(1:118,2:14);
A1=A(1:59,2:14);
A2=A(60:118,2:14);
Lables=A(1:118,1);

no_fea =  13;
  no_sam = 118;
  no_sam1 = 59;
  no_sam1 = 59;

% 
% A1 = Data(Index_C1,Index_Fea);
% A2 = Data(Index_C2,Index_Fea);
% A3=A3;

mean_AA=mean(AA);
mean_A1=mean(A1);
mean_A2=mean(A2);
% mean_A3=mean(A3);


rankE=[];
eigY=[];

W=rand(no_fea,1);
W=W/norm(W);

 

%S_B=(mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA)+(mean_A3-mean_AA)'*(mean_A3-mean_AA);

S_B=59*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));

S_W=zeros(no_fea,no_fea);
 
[i j]=size(A1);
for k0=1:i
        S_W=S_W+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:i
        S_W= S_W+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end



BB=S_B;
EE=S_W;

BBB=S_B;
EEE=S_W;

B=S_B;
E=S_W;


P1=W'*E*W;
P2=W'*B*W;


no_select=13
 
  

WW=[];

traceP=[];
AA0=[A1;A2]; 

for k=1:2
 AA=[A1;A2] 
mean_AA=mean(AA);
 
mean_A1=mean(A1);

mean_A2=mean(A2);



 S_B=59*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));
S_W=zeros(no_fea,no_fea);


 
[i j]=size(A1);
for k0=1:59
        S_W=S_W+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:59
        S_W= S_W+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end



B=S_B;
E=S_W+eye(max(length(S_W)))*0.000001;
% E=S_W ;

[X Y]=eig(B,E)

eigY=[eigY diag(Y)];
rankE=[rankE rank(E)];

[II JJ]=max(max((Y)));

W=X(:,JJ)

if k==1
  W=W/norm(W)
WW=[WW  W]
P_g=WW*pinv(WW)
else

% W=(I-P_g)*W;
 W=W/norm(W)
WW=[WW  W]
P_g=WW*pinv(WW)
end

%WW=WW/norm(WW)
P1=W'*S_W*W;
P2=W'*S_B*W;

PP1=WW'*EEE*WW;
PP2=WW'*BBB*WW;


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


U22110=W'*AA0'        % 第一二类样本在二维上的投影
%U2211=U211;
x0=U22110(1,:);         % 二维投影的第一个坐标   
%y0=U22110(2,:);      % 二维投影的第二个坐标   
W2=W;
 
subplot(2,1,k)
 
plot(x0(1:59) ,'r*')          % 作出二维上的投影图
hold on
plot(x0(60:118),'bo')
 hold on
%plot(x0(101:150),'k^')
%legend('Setosa', 'Versicolor','Virginica')

end
% figure 
% x1=WW'*AA0';         % 第一二类样本在二维上的投影
%  plot(x1(1,1:59) ,'r*')   
%  hold on
%  plot(x1(1,60:118),'bo')
%   hold on
%legend('Setosa', 'Versicolor','Virginica')
figure 
 x1=WW'*AA0'
 x2=x1';
plot(x2(1:59,1) ,x2(1:59,2),'r*')   
hold on
plot(x2(60:118,1),x2(60:118,2),'bo')
 hold on
legend('Setosa', 'Versicolor','Virginica')

 svmStruct= svmtrain(x2,Lables,'showplot',true);
 
classes = svmclassify(svmStruct,x2,'showplot',true);

%classes=svmclassify(svmStruct,data(test,:),'showplot',true)
nCorrect=sum(classes==Lables);
accuracy=nCorrect/length(classes)



