 clc;
 clear;
  load('2k.mat');
  
    AA_tr=fea_tr;
  AA_te=fea_te;
  
  
  no_fea=784;
   train0=fea_tr(lab_tr==0,:);
   train1=fea_tr(lab_tr==1,:);
    train2=fea_tr(lab_tr==2,:);
     train3=fea_tr(lab_tr==3,:);
      train4=fea_tr(lab_tr==4,:);
       train5=fea_tr(lab_tr==5,:);
        train6=fea_tr(lab_tr==6,:);
         train7=fea_tr(lab_tr==7,:);
          train8=fea_tr(lab_tr==8,:);
           train9=fea_tr(lab_tr==9,:);
t0=size(train0,1);
t1=size(train1,1);
t2=size(train2,1);
t3=size(train3,1);
t4=size(train4,1);
t5=size(train5,1);
t6=size(train6,1);
t7=size(train7,1);
t8=size(train8,1);
t9=size(train9,1);
mean_0=mean(train0);
mean_1=mean(train1);
mean_2=mean(train2);
mean_3=mean(train3);
mean_4=mean(train4);
mean_5=mean(train5);
mean_6=mean(train6);
mean_7=mean(train7);
mean_8=mean(train8);
mean_9=mean(train9);

mean_tr=mean(fea_tr);




S_B0=t0*(mean_0-mean_tr)'*(mean_0-mean_tr)+t1*(mean_1-mean_tr)'*(mean_1-mean_tr)+t2*(mean_2-mean_tr)'*(mean_2-mean_tr)+t3*(mean_3-mean_tr)'*(mean_3-mean_tr)+t4*(mean_4-mean_tr)'*(mean_4-mean_tr)+t5*(mean_5-mean_tr)'*(mean_5-mean_tr)+t6*(mean_6-mean_tr)'*(mean_6-mean_tr)+t7*(mean_7-mean_tr)'*(mean_7-mean_tr)+t8*(mean_8-mean_tr)'*(mean_8-mean_tr)+t9*(mean_9-mean_tr)'*(mean_9-mean_tr);

S_W0=zeros(no_fea,no_fea);
for i=1:t0
    S_W0=S_W0+(train0(i,:)-mean_0)'*(train0(i,:)-mean_0);
end
for i=1:t1
    S_W0=S_W0+(train1(i,:)-mean_1)'*(train1(i,:)-mean_1);
end

for i=1:t2
    S_W0=S_W0+(train2(i,:)-mean_2)'*(train2(i,:)-mean_2);
end

for i=1:t3
    S_W0=S_W0+(train3(i,:)-mean_3)'*(train3(i,:)-mean_3);
end

for i=1:t4
    S_W0=S_W0+(train4(i,:)-mean_4)'*(train4(i,:)-mean_4);
end

for i=1:t5
    S_W0=S_W0+(train5(i,:)-mean_5)'*(train5(i,:)-mean_5);
end

for i=1:t6
    S_W0=S_W0+(train6(i,:)-mean_6)'*(train6(i,:)-mean_6);
end

for i=1:t7
    S_W0=S_W0+(train7(i,:)-mean_7)'*(train7(i,:)-mean_7);
end

for i=1:t8
    S_W0=S_W0+(train8(i,:)-mean_8)'*(train8(i,:)-mean_8);
end

for i=1:t9
    S_W0=S_W0+(train9(i,:)-mean_9)'*(train9(i,:)-mean_9);
end
[m1,n1]=size(fea_tr); 
SB=S_B0;
SW=S_W0+eye(max(length(S_W0)))*0.000001;

clear S_B0 S_W0

M=88;
%W=rand(n1,M);
W=randn(n1,M)/2;
W=orth(W);

W1=W;


L=3
  %Q=zeros(n1,n1,M,M);

  Iterations=3000;
  

Cost3=zeros(Iterations,1);
Cost4=zeros(Iterations,1);


for k0=1:Iterations
    
 
   
    TraceSW=trace(W1'*SW*W1);
 TraceSB=trace(W1'*SB*W1);

Grad=(2*SW*W1*TraceSB-2*SB*W1*TraceSW)/(TraceSB^2)+L*(4*W1*W1'*W1-4*W1);
 
 
   W1=W1-0.04*Grad;

   
 Cost3(k0)=TraceSW/TraceSB+L*trace((W1'*W1-eye(M))'*(W1'*W1-eye(M)));

Cost4(k0)=(TraceSW/TraceSB);


    
   
   %  W1=orth(W1);
k0
end

figure(1)
plot(Cost3(1:Iterations),'r-*', 'markersize',4)
xlabel('Iteration number','FontName','Arial','FontSize',11,'FontWeight','Bold');
ylabel('The value of cost function','FontName','Arial','FontSize',11','FontWeight','Bold');
legend('TBGM')
set(gca,'LineWidth', 1.5,'FontName','Arial','FontWeight','Bold')
export_fig MNISTit.eps -painters -transparent


x1=W'*AA_tr';
 x2_tr=x1';
x1_te=W'*AA_te';
x2_te=x1_te';

% model= svmtrain2(lab_tr,x2_tr,'-c 2 -t 2 -g 1 -q ');
% [predict_label, accuracy, dec_values]= svmpredict(lab_te,x2_te,model);

predict_label = knnclassify(x2_te, x2_tr,lab_tr, 1);
accuracy = length(find(predict_label==lab_te))/length(lab_te)*100

