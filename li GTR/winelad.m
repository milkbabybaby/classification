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



rankE=[];
eigY=[];




AA=[A1;A2] 
mean_AA=mean(AA);
 
mean_A1=mean(A1);

mean_A2=mean(A2);


no_select=13


WW=[];

traceP=[];


 S_B=118*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));
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


[II JJ]=max(max((Y)));

W=X(:,JJ)



% W=(I-P_g)*W;
 W=W/norm(W)




%trace_(k)=trace(P2)/trace(P1);
%trace1_(k)=trace(PP2)/trace(PP1);

%traceP=[traceP ; trace(P2) trace(P1)  trace(PP2) trace(PP1)] 







% figure 
% x1=WW'*AA0';         % 第一二类样本在二维上的投影
%  plot(x1(1,1:59) ,'r*')   
%  hold on
%  plot(x1(1,60:118),'bo')
%   hold on
%legend('Setosa', 'Versicolor','Virginica')

 x1=W'*AA'
 x2=x1';
plot(x2(1:59,1) ,'r*')   
hold on
plot(x2(60:118,1),'bo')
 hold on


 svmStruct= svmtrain(x2,Lables,'showplot',true);
 
classes = svmclassify(svmStruct,x2,'showplot',true);

%classes=svmclassify(svmStruct,data(test,:),'showplot',true)
nCorrect=sum(classes==Lables);
accuracy=nCorrect/length(classes)