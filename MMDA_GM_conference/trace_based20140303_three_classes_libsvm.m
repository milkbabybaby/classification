clear all 
clc
 
format short
clear all 
clc
A11=[5.1 3.5 1.4 0.2 ;4.9 3.0 1.4 0.2 ;4.7 3.2 1.4 0.2 ; 4.6  3.1  1.5 0.2 ; 5.0 3.6 1.4 0.2;
   5.4 3.9 1.7 0.4 ; 4.6 3.4 1.4 0.3;5.0 3.4 1.5 0.2; 4.9 3.1 1.5 0.1;5.4 3.7 1.5 0.2 ;4.8 3.4  1.6 0.2 ; 
   4.8 3.0 1.4 0.1;.3 3.0 1.1 0.1;4.3 3.0 1.1 0.1;5.8 4.0 1.2 0.2;5.7 4.4 1.5 0.4; 5.4 3.9 1.3 0.4 ;
   5.1 3.5 1.4 0.3 ;5.7 3.8 1.7 0.3 ; 5.1 3.8 1.5 0.3;5.4 3.4 1.7 0.2 ; 5.1 3.7 1.5  0.4; 4.6 3.6 1.0 0.2 ;
   5.1 3.3 1.7 0.5; 4.8 3.4 1.9 0.2 ];  %   ��һ��ѧϰ����
A22=[7.0 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8 6.2 5.6 5.9 6.1 6.3 6.1 6.4 ;
    3.2 3.2 3.1 2.3 2.8 2.8 3.3 2.4 2.9 2.7 2.0 3.0 2.2 2.9 2.9 3.1 3.0 2.7 2.7 2.5 3.2 2.8 2.5 2.8 2.9 ;
    4.7 4.5 4.9 4.0 4.6 4.5 4.7 3.3 4.6 3.9 3.5 4.2 4.0 4.7 3.6 4.4 4.5 4.1  4.5 3.9 4.8 4.0 4.9 4.7 4.3;
    1.4 1.5 1.5 1.3 1.5 1.3 1.6 1.0 1.3 1.4 1.0 1.5 1.0 1.4 1.3 1.4 1.5 1.0 1.5 1.1 1.8 1.3 1.5 1.2 1.3]'; %   �ڶ���ѧϰ����
A33=[ 6.3 5.8 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7 6.0 6.9 5.6 7.7 6.3 6.7 ;
     3.3 2.7 3.0 2.9 3.0 3.0 2.5 2.8 2.5 3.6 3.2 2.7 3.0 2.5 2.8 3.2 3.0 3.8 2.6 2.2 3.2 2.8 2.8 2.7 3.3;
     6.0 5.1 5.9 5.6 5.8 6.6 4.5 6.3 5.8 6.1 5.1 5.3 5.5 5.0 5.1 5.3 5.5 6.7 6.9 5.0 5.7 4.9 6.7 4.9 5.7 ;
     2.5 1.9 2.1 1.8 2.2 2.1 1.7 1.8 1.8 2.5 2.0 1.9 2.1 2.0 2.4 2.3 1.8 2.2 2.3 1.5 2.3 2.0 2.0 1.8 2.1]';
 A111=[5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0;
     3.0 3.4 3.5 3.4 3.2 3.1 3.4 4.1 4.2 3.1 3.2 3.5 3.1 3.0 3.4 3.5 2.3 3.2 3.5 3.8 3.0 3.8 3.2 3.7 3.3 ;
     1.6 1.6 1.5 1.4 1.6 1.6 1.5 1.5 1.4 1.5 1.2 1.3 1.5 1.3 1.5 1.3 1.3 1.3 1.6 1.9 1.4 1.6 1.4 1.5 1.4 ;
     0.2 0.4 0.2 0.2 0.2 0.2 0.4 0.1 0.2 0.1 0.2 0.2 0.1 0.2 0.2 0.3 0.3 0.2 0.6 0.4 0.3 0.2 0.2 0.2 0.2 ]';
 A222=[6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 ;
     3.0 2.8 3.0 2.9 2.6 2.4 2.4 2.7 2.7 3.0 3.4 3.1 2.3 3.0 2.5 2.6 3.0 2.6 2.3 2.7 3.0 2.9 2.9 2.5 2.8 ;
     4.4 4.8 5.0 4.5 3.5 3.8 3.7 3.9 5.1 4.5 4.5 4.7 4.4 4.1 4.0 4.4 4.6 4.0 3.3 4.2 4.2 4.2 4.3 3.0 4.1 ;
     1.4 1.4 1.7 1.5 1.0 1.1 1.0 1.2 1.6 1.5 1.6 1.5 1.3 1.3 1.3 1.2 1.4 1.2 1.0 1.3 1.2 1.3 1.3 1.1 1.3 ]';
 A333=[7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9;
     3.2 2.8 3.0 2.8 3.0 2.8 3.8 2.8 2.8 2.6 3.0 3.4 3.1 3.0 3.1 3.0 3.1 2.7 3.2 3.3 3.0  2.5 3.0 3.4 3.0;
     6.0 4.8 4.9 5.6 5.8 6.1 6.4 5.6 5.1 5.6 6.1 5.6 5.5 4.8 5.4 5.6 5.1 5.1 5.9 5.7 5.2 5.0 5.2 5.4 5.1
     1.8 1.8 1.8 2.1 1.6 1.9 2.0 2.2 1.5 1.4 2.3 2.4 1.8 1.8 2.1 2.4 2.3 1.9 2.3 2.5 2.3 1.9 2.0 2.3 1.8]';
 
 

A1=[A11; A111];
A2=[A22; A222];
A3=[A33; A333];

AA=[A1;A2;A3]; 
AB=[A1;A2;A3];
  no_fea =  4;
  no_sam = 150;
  no_sam1 = 50;
  no_sam2 = 50;
% 
% A1 = Data(Index_C1,Index_Fea);
% A2 = Data(Index_C2,Index_Fea);
% A3=A3;

mean_AA=mean(AA);
mean_A1=mean(A1);
mean_A2=mean(A2);
 mean_A3=mean(A3);


rankE=[];
eigY=[];

W=rand(no_fea,1);
W=W/norm(W);

 

%S_B=(mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA)+(mean_A3-mean_AA)'*(mean_A3-mean_AA);

S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA)+(mean_A3-mean_AA)'*(mean_A3-mean_AA));

S_W=zeros(no_fea,no_fea);
 
[i j]=size(A1);
for k0=1:i
        S_W=S_W+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:i
        S_W= S_W+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end

for k0=1:i
        S_W= S_W+(A3(k0,:)-mean_A3)'*(A3(k0,:)-mean_A3);
end

BB=S_B;
EE=S_W;

BBB=S_B;
EEE=S_W;

B=S_B;
E=S_W;


P1=W'*E*W;
P2=W'*B*W;


no_select=4
 
  

WW=[];

traceP=[];

for k=1:no_select
 AA=[A1;A2;A3]; 
mean_AA=mean(AA)
 
mean_A1=mean(A1)

mean_A2=mean(A2)

mean_A3=mean(A3)

 S_B=150*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA)+(mean_A3-mean_AA)'*(mean_A3-mean_AA));
%S_B=50*((mean_A1-mean_AA)'*(mean_A1-mean_AA)+(mean_A2-mean_AA)'*(mean_A2-mean_AA));
S_W=zeros(no_fea,no_fea);
 
[i j]=size(A1);
for k0=1:50
        S_W=S_W+(A1(k0,:)-mean_A1)'*(A1(k0,:)-mean_A1);
end


for k0=1:50
        S_W= S_W+(A2(k0,:)-mean_A2)'*(A2(k0,:)-mean_A2);
end

 for k0=1:50
          S_W= S_W+(A3(k0,:)-mean_A3)'*(A3(k0,:)-mean_A3);
 end

B=S_B;
E=S_W+eye(max(length(S_W)))*0.000001;
% E=S_W ;

[X Y]=eig(B,E)

eigY=[eigY diag(Y)];
rankE=[rankE rank(E)];

[II JJ]=max(max((Y)));

W=X(:,JJ);

if k==1
  W=W/norm(W);
WW=[WW  W];
P_g=WW*pinv(WW)
else

% W=(I-P_g)*W;
 W=W/norm(W);
WW=[WW  W];
P_g=WW*pinv(WW)
end

%WW=WW/norm(WW)
P1=W'*S_W*W;
P2=W'*S_B*W;

PP1=WW'*EEE*WW;
PP2=WW'*BBB*WW;


trace_(k)=trace(P2)/trace(P1);
trace1_(k)=trace(PP2)/trace(PP1);

traceP=[traceP ; trace(P2) trace(P1)  trace(PP2) trace(PP1)] 

I=diag(ones(no_fea,1));
%  
 A11=((I-P_g)*A1')';
 A22=((I-P_g)*A2')';
 A33=((I-P_g)*A3')';
  
  A1=A11;
  A2=A22;
    A3=A33;


U22110=W'*AA';         % ��һ���������ڶ�ά�ϵ�ͶӰ
%U2211=U211;
x0=U22110(1,:);         % ��άͶӰ�ĵ�һ������   
%y0=U22110(2,:);      % ��άͶӰ�ĵڶ�������   
W2=W;
 
subplot(2,2,k)
 
plot(x0(1:50) ,'r*')          % ������ά�ϵ�ͶӰͼ
hold on
plot(x0(51:100),'bo')
 hold on
plot(x0(101:150),'k^')
legend('Setosa', 'Versicolor','Virginica')

end

x2=AB*WW;
Lables=[ones(50,1); -ones(50,1);3*ones(50,1);];
model= svmtrain2(Lables,x2,'-t 2  -g 2');
[predict_label, accuracy_x23, dec_values_x2]= svmpredict(Lables,x2,model);



% x2=AB(1:100,:)*WW;
% figure(3)
% % model_12= svmtrain2(Lables,x2,'-t 2 -g 1');
% % [predict_label, accuracy_x12, dec_values_x2]= svmpredict(Lables,x2,model_12);
%  svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','QP','showplot',true); 
%  
% classes = svmclassify(svmStruct,x2);
% nCorrect=sum(classes==Lables);
% accuracy_12=nCorrect/length(classes)
% 
% Lables=[ones(50,1); -ones(50,1);];
% figure(4)
% x2=AB(51:150,:)*WW;
% % 
% % model_23= svmtrain2(Lables,x2,'-t 2 -g 1');
% % [predict_label, accuracy_x23, dec_values_x2]= svmpredict(Lables,x2,model_23);
% 
%  svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','QP','showplot',true); 
%  
% classes = svmclassify(svmStruct,x2);
% nCorrect=sum(classes==Lables);
% accuracy_23=nCorrect/length(classes)
% 
% Lables=[ones(50,1); -ones(50,1);];
% figure(5 )
% AA_13=[AB(1:50,:); AB(101:150,:)]; 
% x2=AA_13*WW;
% % model_13= svmtrain2(Lables,x2,'-t 2 -g 1');
% % [predict_label, accuracy_x13, dec_values_x2]= svmpredict(Lables,x2,model_13);
% % 
% %  accuracy=(accuracy_x13+accuracy_x23+ accuracy_x13)/3;
% 
%  svmStruct= svmtrain(x2,Lables,'Kernel_Function','rbf','method','QP','showplot',true); 
%  
% classes = svmclassify(svmStruct,x2);
% nCorrect=sum(classes==Lables);
% accuracy_13=nCorrect/length(classes)
% 
% 
% accuracy=(accuracy_13+accuracy_23+ accuracy_13)/3



% gtext('Projection on the first extracted feature')
% gtext('Projection on the second extracted feature')
% gtext('Projection on the third extracted feature')
% gtext('Projection on the fourth extracted feature')
 

%  

 [X Y]=eig(BB,EE);

XX=[];
 for k=1:no_fea
  XX=[ XX X(:,no_fea-k+1)/norm(X(:,no_fea-k+1))];
 end
 X = orth(X);

 W
 
 P1=XX'*EE*XX;
 P2=XX'*BB*XX;
 trace_k1=trace(P2)/trace(P1) 
 
 P1=WW'*EE*WW;
 P2=WW'*BB*WW;
 trace_k2=trace(P2)/trace(P1)  
 

figure(10)
 plot(trace_,'r-*')
 xlabel(' The order number of extracted features ')
ylabel('The trace ratio  for each  extracted features')
 
 hold  on
 
plot(trace_,'b-*')