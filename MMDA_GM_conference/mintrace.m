clear;
tt=0.15;
a=imread('D:\yaleface\1\s1.bmp');
 a=imresize(a,tt);

[m,n]=size(a);
allsamples=[];
for i=1:10
    for j=1:5
        a=imread(strcat('D:\yaleface\',num2str(i),'\s',num2str(j),'.bmp'));
       a=imresize(a,tt);
        %imshow(a);
        
        b=a(1:m*n);
        b=double(b);
        allsamples=[allsamples;b];
    end
end
[m1,n1]=size(allsamples);




u=mean(allsamples);


    
sample1=allsamples(1:5,:);u1=mean(sample1);s1=cov(sample1,1);
sample2=allsamples(6:10,:);u2=mean(sample2);s2=cov(sample2,1);
sample3=allsamples(11:15,:);u3=mean(sample3);s3=cov(sample3,1);
sample4=allsamples(16:20,:);u4=mean(sample4);s4=cov(sample4,1);
sample5=allsamples(21:25,:);u5=mean(sample5);s5=cov(sample5,1);
sample6=allsamples(26:30,:);u6=mean(sample6);s6=cov(sample6,1);
sample7=allsamples(31:35,:);u7=mean(sample7);s7=cov(sample7,1);
sample8=allsamples(36:40,:);u8=mean(sample8);s8=cov(sample8,1);
sample9=allsamples(41:45,:);u9=mean(sample9);s9=cov(sample9,1);
sample10=allsamples(46:50,:);u10=mean(sample10);s10=cov(sample10,1);


sw=s1+s2+s3+s4+s5+s6+s7+s8+s9+s10;
%sb=(u1-u)*(u1-u)'+(u2-u)*(u2-u)'+(u3-u)*(u3-u)'+(u4-u)*(u4-u)'+(u5-u)*(u5-u)'+(u6-u)*(u6-u)'+(u7-u)*(u7-u)'+(u8-u)*(u8-u)'+(u9-u)*(u9-u)'+(u10-u)*(u10-u)';
sb=(u1-u)'*(u1-u)+(u2-u)'*(u2-u)+(u3-u)'*(u3-u)+(u4-u)'*(u4-u)+(u5-u)'*(u5-u)+(u6-u)'*(u6-u)+(u7-u)'*(u7-u)+(u8-u)'*(u8-u)+(u9-u)'*(u9-u)+(u10-u)'*(u10-u);
S=sb-sw;
M=2;
W=eye(n1,M);
%B=-W'*S*W % under the constraint W'W=I, B=-W'*S*W
B=-inv(W'*W)*W'*S*W;
W0=zeros(n1,M);
k=1;

while norm(W-W0,1)>0.001
Aeq=[];
beq=[];
lb=[];
ub=[];
options=optimset('largescale','off','display','off');
W2=fmincon(@(W)myfun1(W,S,B),W0,[],[],[],[],[],[],@(W)mycon(W),options);
W0=W;
W=W2;



B=-W'*S*W;

u0=max(eig(B));

S=sb-u0*sw;
% for i = 1 :M
% W(:,i) = W(:,i) / norm(W(:,i) );
% end
k=k+1
norm(W-W0,1)
end;


z=W'*allsamples';
accu=0;
for i=1:10
    for j=6:10
        a=imread(strcat('D:\yaleface\',num2str(i),'\s',num2str(j),'.bmp'));
        a=imresize(a,(100*tt)^2);
        b=a(1:2500);
        b=double(b);
        b=b';
        tcoor=W'*b;
     for k=1:50
            mdist(k)=norm(tcoor-z(:,k));
             end
 [dist,index2]=sort(mdist);
             class1=floor((index2(1)-1)/5)+1;
             class2=floor((index2(2)-1)/5)+1;
             class3=floor((index2(3)-1)/5)+1;
        if  class1~=class2&&class2~=class3
            class=class1;
        elseif class1==class2
            class=class1;
        elseif class2==class3
            class=class2;
        end
        if class==i
            accu=accu+1;
        end;
    end;
end;
accuracy=accu/50
        




