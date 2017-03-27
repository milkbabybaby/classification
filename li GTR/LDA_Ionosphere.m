clear;

load('Ionospheredata.mat');
AA=sortrows(A,35);
A1=AA(1:225,1:34);
A2=AA(226:351,1:34);
Lables=AA(:,35);

no_fea =  34;
no_sam = 351;
no_sam1 = 225;
no_sam1 = 126;




AA=[A1;A2] 
mean_AA=mean(AA);
 
mean_A1=mean(A1);

mean_A2=mean(A2);


no_select=34;


WW=[];

traceP=[];


S_B=225*(mean_A1-mean_AA)'*(mean_A1-mean_AA)+126*(mean_A2-mean_AA)'*(mean_A2-mean_AA);
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


[II JJ]=max(max((Y)));

W=X(:,JJ)



% W=(I-P_g)*W;
 W=W/norm(W)




%trace_(k)=trace(P2)/trace(P1);
%trace1_(k)=trace(PP2)/trace(PP1);

%traceP=[traceP ; trace(P2) trace(P1)  trace(PP2) trace(PP1)] 

x1=W'*AA'
x2=x1';
plot(x2(1:225) ,'r*')   
hold on
plot(x2(226:351),'bo')
hold on
legend('good', 'bad')



%predict_label = knnclassify(x2, x2,Lables, 8);
%accuracy = length(find(predict_label ==Lables))/length(Lables)*100

%model= svmtrain2(Lables,x2,'-t 2 ');

%[predict_label, accuracy, dec_values]= svmpredict(Lables,x2,model);
svmStruct= svmtrain(x2,Lables,'Kernel_Function','linear','method','QP','showplot',true); 
classes = svmclassify(svmStruct,x2);
nCorrect=sum(classes==Lables);
accuracy=nCorrect/length(classes)