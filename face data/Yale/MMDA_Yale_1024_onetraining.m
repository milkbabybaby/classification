%  11 examples per class;  15 classes ; 165 examples in total;clear;
close all
clc;
clear;
tic;
load('Yale_Scale_32x32.mat');
no_fea =1024;
class_num=15;
tr_num=9;
te_num=11-tr_num;
lab_tr=[];
lab_te=[];
AA_tr=[];
AA_te=[];
AAA_tr=[];
AAAA_tr=[];
AAAAA_tr=[];


 for k=1:15
  A_tr(1:tr_num,1:1024,k)=fea((k-1)*11+1:(k-1)*11+tr_num,:);
  B_tr(k,1:1024)=mean(A_tr(:,:,k));
  lab_tr=[lab_tr;gnd((k-1)*11+1:(k-1)*11+tr_num)];
  A_te(1:te_num,1:1024,k)=fea((k-1)*11+tr_num+1:11*k,:);
  lab_te=[lab_te;gnd((k-1)*11+tr_num+1:11*k)];
  AA_tr=[AA_tr;A_tr(:,:,k)];
  AA_te=[AA_te;A_te(:,:,k)];
 end
mean_B=mean(B_tr);


kk=2
p=1
for j=1:class_num
        [IDX,D]= knnsearch(A_tr(:,:,j),A_tr(:,:,j),'k',kk);
        IDXXX=IDX';
              IDXX(:,:,j)=IDXXX;
        %DD(:,:,j)=D;
end 
for j=1:class_num
    AAA_tr=[];
    C_tr=[];
    DDD_tr=[];
    for i=1:tr_num
        D_tr=A_tr(IDXX(:,i,j),:,j);
        D_tr(1,:)=p*D_tr(1,:);
        DD_tr=sum(D_tr,1)/(p+kk-1);
        DDD_tr=[DDD_tr;DD_tr];
        C_tr=[C_tr; A_tr(IDXX(:,i,j),:,j)];
   AAA_tr=  [AAA_tr; mean(A_tr(IDXX(:,i,j),:,j),1)];
    end 
    AAAA_tr(:,:,j)=AAA_tr;
     CC_tr(:,:,j)=C_tr;
     DDDD_tr(:,:,j)=DDD_tr;
    AAAAA_tr=[AAAAA_tr;AAA_tr];
    BB_tr(j,1:1024)=mean(AAAA_tr(:,:,j));
   BBB_tr(j,1:1024)=mean(DDDD_tr(:,:,j))
end 


mean_BB=mean(BB_tr);
mean_BBB=mean(BBB_tr);

S_B0=zeros(no_fea,no_fea);
 for k=1:class_num
 S_B0=tr_num*(BB_tr(k,:)-mean_BBB)'*(BB_tr(k,:)-mean_BBB)+S_B0;
  S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
%   for i=1:tr_num
%       S_B0=(AAAA_tr(i,:,k)-mean_B)'*(AAAA_tr(i,:,k)-mean_B)+S_B0;
%  end 
 end

S_W0=zeros(no_fea,no_fea);
for k=1:class_num
    for i=1:tr_num
     S_W0=S_W0+(DDDD_tr(i,:,k)-BBB_tr(k,:))'*(DDDD_tr(i,:,k)-BBB_tr(k,:));% a-'-m
   S_W0=S_W0+(A_tr(i,:,k)-B_tr(k,:))'*(A_tr(i,:,k)-B_tr(k,:));
%         for m=1:kk
%          S_W0=S_W0+(CC_tr(kk*(i-1)+m,:,k)-AAAA_tr(i,:,k))'*(CC_tr(kk*(i-1)+m,:,k)-AAAA_tr(i,:,k));% 小的类间距
%          end 
     end
end

% S_B0=zeros(no_fea,no_fea);
%  for k=1:15
%  S_B0=tr_num*(B_tr(k,:)-mean_B)'*(B_tr(k,:)-mean_B)+S_B0;
%  end
% 
% S_W0=zeros(no_fea,no_fea);
% for k=1:15
%     for i=1:tr_num
%        S_W0=S_W0+(AAAA_tr(i,:,k)-B_tr(k,:))'*(AAAA_tr(i,:,k)-B_tr(k,:));
%     end
% end



[m1,n1]=size(fea);
SB=S_B0; 
SW=S_W0+eye(max(length(S_W0)))*0.000001;

%  
%  

v=6
%A=SW-v*SB;
A=-(SB-v*SW);
M=6;
W=rand(n1,M);
W2=W;
R2=eye(M);
I=eye(M);
R=rand(M,M);
R=R+R';
  
Iterations=400;
  
 r1=0.3
  
r2=1

 r12=0.2
  
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
 %W=orth(W);     
      
Cost1(k)=trace(W'*A*W)+trace((R.*(W'*W-I))'*(R.*(W'*W-I)));  
Cost2(k)=trace((R.*(W'*W-I))'*(R.*(W'*W-I)));
Cost3(k)=trace(W'*A*W);


%%%%%%%%%%%% diagnal 
DF3=2*A*W2+2*W2*(R2'*R2)*W2'*W2+2*W2*W2'*W2*(R2'*R2)-4*W2*R2'*R2;
%DF1=2*(SB-v*SW)*W+2*W*(R'*R)*W'*W+2*W*W'*W*(R'*R)-4*W*R'*R;
DF3=DF3/norm(DF3);
W2=W2-r12*DF3;
W2=orth(W2);

%  
% DF4=diag(diag(2*R2*W2'*W2*W2'*W2-4*R2*W2'*W2+2*R2));
% DF4=DF4/norm(DF4);
%  %if  Cost2(k)>0.01
%             R2=R2+r22*DF4;
% %end
      
      
Cost4(k)=trace(W2'*A*W2)+trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);  
Cost5(k)=trace(W2'*W2*R2'*R2*W2'*W2-R2'*R2*W2'*W2-W2'*W2*R2'*R2+R2'*R2);
Cost6(k)=trace(W2'*A*W2);
 k 
end
 
% figure(1)
% plot(Cost1(1:Iterations),'r-*')
% xlabel('Iteration number','FontName','Arial','FontSize',11,'FontWeight','Bold');
% ylabel('The value of cost function','FontName','Arial','FontSize',11,'FontWeight','Bold');
% 
% set(gca,'LineWidth', 1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')
% 
% %myzoom([0.22,0.18,0.42,0.2],[10,70,83,95])
% 
% export_fig yale_iter.eps -painters -transparent


% figure(2)
% plot(Cost1(1:Iterations),'r-*')
% set(gca,'yscale','log')
% ylabel('The value of cost function');
% xlabel('Iteration number');
 
 
% figure(2)
% plot(Cost2(1:Iterations),'r-*')
% 
% figure(3)
% plot(Cost3(1:Iterations),'r-*')
% 
% figure(4)
% plot(Cost4(1:Iterations),'r-*')
%ylabel('The value of cost function');
%xlabel('Iterations');
 
%  
% figure(5)
% plot(Cost5(1:Iterations),'r-*')
% 
% figure(6)
% plot(Cost6(1:Iterations),'r-*')
 
 x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

 model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
 [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
vaccuracy = length(find(predict_label==lab_te))/length(lab_te)*100

 x1=W2'*AA_tr';
 x2_tr=x1';
x1_te=W2'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100
% 

%%plot example 
% close all
% x11=A_tr(:,:,13)*W;
% x12=A_tr(:,:,14)*W;
% x13=A_tr(:,:,11)*W;
% x14=A_tr(:,:,1)*W;
%  figure(8)
% plot(x11(:,1),x11(:,2),'g*','LineWidth',1.5,'markersize',8)
% hold on
% plot(x12(:,1),x12(:,2),'r+','LineWidth',1.5,'markersize',8)
% hold on
% plot(x13(:,1),x13(:,2),'bo','LineWidth',1.5,'markersize',8)
% hold on
% plot(x14(:,1),x13(:,2),'k^','LineWidth',1.5,'markersize',8)
% ylabel('The coordinate of the first extracted feature','FontName','Arial','FontSize',11,'FontWeight','Bold');
% xlabel('The coordinate of the second extracted feature','FontName','Arial','FontSize',11,'FontWeight','Bold');
% 
% set(gca,'LineWidth',1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')
% 
% export_fig Yale_tr.eps -painters -transparent
% 
% 
% x11=A_te(:,:,13)*W;
% x12=A_te(:,:,14)*W;
% x13=A_te(:,:,11)*W;
% x14=A_te(:,:,1)*W;
%  figure(9)
% plot(x11(:,1),x11(:,2),'g*','LineWidth',1.5,'markersize',8)
% hold on
% plot(x12(:,1),x12(:,2),'r+','LineWidth',1.5,'markersize',8)
% hold on
% plot(x13(:,1),x13(:,2),'bo','LineWidth',1.5,'markersize',8)
% hold on
% plot(x14(:,1),x13(:,2),'k^','LineWidth',1.5,'markersize',8)
% ylabel('The coordinate of the first extracted feature','FontName','Arial','FontSize',11,'FontWeight','Bold');
% xlabel('The coordinate of the second extracted feature','FontName','Arial','FontSize',11,'FontWeight','Bold');
% 
% set(gca,'LineWidth',1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')
% 
% export_fig Yale_te.eps -painters -transparent
