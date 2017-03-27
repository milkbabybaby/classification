%fea=samples*fea*class 1100*256*10
clear;
clc;
load('semeion_144');
no_fea =144;
A_tr=A_tr0;
   AA_tr=fea_tr0;
  AA_te=fea_te0;
%  mean_B=mean(B_tr);
clear A_tr0 fea_tr0 fea_te0
    
    for k=1:10
        B_tr(k,1:no_fea)=mean(A_tr(:,:,k));
    end 
mean_B=mean(B_tr);
  
  S_B0=zeros(no_fea,no_fea);
    for k=1:10
      S_B0=100*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
  end

  
  
  S_W0=zeros(no_fea,no_fea);
 for k=1:10
     for i=1:100
        S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
     end
 end
 
[m1,n1]=size(AA_tr); 
SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;

clear S_B0 S_W0

M=100;
%W=rand(n1,M);
W=randn(n1,M)/2;
W=orth(W);
W0=W;
W1=W;

 
I1=eye(n1);
I2=eye(M);
NN=n1*M;
I0=eye(NN);
L=100

  %Q=zeros(n1,n1,M,M);
  A=SW;
  B=SB;
 WW=reshape(W,NN,1); 
  Iterations=5000;
  
Cost0=zeros(Iterations,1);  
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);
Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);


for k0=1:Iterations
    
%  Trace_SW=trace(W'*A*W);
%  Trace_SB=trace(W'*B*W);
%  
%  Cost1(k0)=Trace_SW/Trace_SB+L*trace((W'*W-eye(M))'*(W'*W-eye(M)));
% 
% Cost2(k0)=(Trace_SW/Trace_SB); 
% 
% 
%  
%  P111=-2*B*W/ Trace_SB;
%  P112=A*W;
%  
%  P211=-2*A*W/ (Trace_SB^2);
%  P212=B*W;
%  P221=4*B*W*Trace_SW/(Trace_SB^3);
%  P222=B*W;
%  P231=-Trace_SW/Trace_SB*B;
% 
%  P312=W'*W;
%  P331=W*W';
%  
%  for i=1:n1
%     for j= 1:M
%         for k =1:M
%             for l=1:n1
%                Q(i,l,k,j)=2*(P111(l,k)*P112(i,j)+A(i,l)*I2(k,j)/Trace_SB+P211(l,k)*P212(i,j)+P221(l,k)*P222(i,j)+P231(i,l)*I2(k,j))+L*4*(I1(i,l)*P312(k,j)+W(i,k)*W(l,j)+P331(i,l)*I2(k,j)-I1(i,l)*I2(k,j));
%                %M(i,n,m,j)=I(j,m)*A(i,n)+2*(P111(i,n)*P112(m,j)+P121(i,m)*P122(n,j)+P131(i,n)*I(m,j)+I(i,n)*P212(m,j)+P221(i,m)*P222(n,j)+P231(i,n)*I(m,j)); %+I(j,m)*A(n,i) change the order i j m n into i n m j to avoid "squeeze" tensor in the following operations since M(:,:,:,1) is three order while M(:,1,:,:) is four order 
%             end
%         end
%     end
% end
% 
%  QQ=[];
% for j=1:M;
% QQ=[QQ; Q(:,:,:,j)]; % combine three order tensor in the i direction, then the first "block row" is j=1, the second "block row" is j=2 
% end
%  
% clear Q
% 
% QQQ=[];
% for k=1:M;
% QQQ=[QQQ QQ(:,:,k)]; %combine matrix in the n direction, then the first " block column" is m=1, the second " block column" is m=2 
% end%  Newton method
% 
% clear QQ
% P=(2*SW*W*Trace_SB-2*SB*W*Trace_SW)/(Trace_SB)^2+L*(4*W*W'*W-4*W);
% PP=reshape(P,NN,1); %reshape first order derivative into a vetor 
%     WW=WW-0.8*inv(QQQ+0.5*I0)*PP;  % update XX
%    % WW=WW-inv(QQQ)*PP;
%     W=reshape(WW,n1,M); 


% u=0
%  [R,p]=chol(QQQ+u*I0);
%   
%  if p~=0
%      u=0.01
%  
% [R,p]=chol(QQQ+u*I0);
%  while    p~=0
%     u=4*u
%   [R,p]=chol(QQQ+u*I0);
%  end 
%  end
%  




         




 TraceSW=trace(W1'*A*W1);
 TraceSB=trace(W1'*B*W1);
 
 Cost3(k0)=TraceSW/TraceSB+L*trace((W1'*W1-eye(M))'*(W1'*W1-eye(M)));

Cost4(k0)=(TraceSW/TraceSB);

Grad=(2*SW*W1*TraceSB-2*SB*W1*TraceSW)/(TraceSB)^2+L*(4*W1*W1'*W1-4*W1);
    
     W1=W1-0.002*Grad;
k0
end

x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100


x1=W1'*AA_tr';
 x2_tr=x1';
x1_te=W1'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
