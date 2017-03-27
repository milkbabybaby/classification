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


SW=s1+s2+s3+s4+s5+s6+s7+s8+s9+s10;
%sb=(u1-u)*(u1-u)'+(u2-u)*(u2-u)'+(u3-u)*(u3-u)'+(u4-u)*(u4-u)'+(u5-u)*(u5-u)'+(u6-u)*(u6-u)'+(u7-u)*(u7-u)'+(u8-u)*(u8-u)'+(u9-u)*(u9-u)'+(u10-u)*(u10-u)';
SB=(u1-u)'*(u1-u)+(u2-u)'*(u2-u)+(u3-u)'*(u3-u)+(u4-u)'*(u4-u)+(u5-u)'*(u5-u)+(u6-u)'*(u6-u)+(u7-u)'*(u7-u)+(u8-u)'*(u8-u)+(u9-u)'*(u9-u)+(u10-u)'*(u10-u);
%sw=sw+eye(max(length(sw)))*0.000001
%[X Y]=eig(inv(sw)*sb);

v=2;
SB=SB/1000000;
SW=SW/1000000;
A=SB-v*SW;

M=6;
WW=rand(n1,M);
W=[];
for i=1:M;
W=[W WW(:,i)/norm(WW(:,i))];
W=orth(W);
end


%B=-W'*S*W; % under the constraint W'W=I, B=-W'*S*W
B=-inv(W'*W)*W'*A*W;
W0=zeros(n1,M);
k=1;
WW=rand(n1,M);
W=[];
for i=1:M;
W=[W WW(:,i)/norm(WW(:,i))];
W=orth(W);
end

%B=-W'*S*W; % under the constraint W'W=I, B=-W'*S*W
B=-inv(W'*W)*W'*A*W;
W0=zeros(n1,M);
k=1;

%while norm(W'*W-eye(M),'fro')>0.01
while  norm(W-W0,'fro')>0.0001 
%while k<3
 i=1;
 W_old=W

while 1
Grad=2*A'*A*W_old+4*A*W_old*B+2*W_old*B*B'+1000*(4*W_old*W_old'*W_old-4*W_old);
F1=norm(A*W_old+W_old*B,'fro')
F10=norm(A*W_old+W_old*B,'fro')+1000*norm(W_old'*W_old-eye(M),'fro')
W_new=W_old-0.0001*Grad
F2=norm(A*W_new+W_new*B,'fro')
F20=norm(A*W_new+W_new*B,'fro')+1000*norm(W_new'*W_new-eye(M),'fro')

if isnan(F2)
    break;
end


F0=norm(Grad,'fro')
%break
if F0<0.1

W_best = W_new
break;
end

W_old=W_new;
i=i+1
end


W0=W;
%W=W_bestorth
W=W_best;

B=-inv(W'*W)*W'*A*W;

SB_update=W'*SB*W;
SW_update=W'*SW*W;
[X Y]=eig(SB_update,SW_update);
%v0=max(max((Y)));
v0=1;
A=SB-v0*SW;
k=k+1
F3=norm(W-W0,'fro')
end;

% %while norm(W'*W-eye(M),'fro')>0.01
% %while norm(W-W0,'fro')>0.0001 
%  while k<2
%  i=1;
%  W_old=W
%  
% while i<2
%     
% Grad=2*A'*A*W_old+4*A*W_old*B+2*W_old*B*B'+1000*(3*W_old*W_old'*W_old-2*W_old);
% F1=norm(A*W_old+W_old*B,'fro')
% %F1=norm(A*W_old+W_old*B,'fro')+1000*norm(W_old'*W_old-eye(M),'fro')
% W_new=W_old-0.00000001*Grad
% %F2=norm(A*W_new+W_new*B,'fro')+1000*norm(W_new'*W_new-eye(M),'fro')
% F2=norm(A*W_new+W_new*B,'fro')
% 
% 
% % Grad=3*W_old*W_old'*W_old-2*W_old;
% % F1=norm(W_old'*W_old-eye(M),'fro')
% % W_new=W_old-0.001*Grad
% % F2=norm(W_new'*W_new-eye(M),'fro')
% %if norm(W_new-W_old,'fro')<0.00000001
% 
% F0=abs(F2-F1)
% if  F0<0.00001
% W_best = W_new
% break;
% end
% W_old=W_new;
% i=i+1
% end
% 
% W_bestorth=GS(W_best);
% %W3=orth(W2);
% 
% 
% 
% W0=W;
% W=W_bestorth
% %W=W_best;
% 
% B=-inv(W'*W)*W'*A*W;
% % SB_update=W'*SB*W;
% % SW_update=W'*SW*W;
% % [X Y]=eig(SB_update,SW_update);
% % v0=max(max((Y)));
% A=SB-v0*SW;
% % for i = 1 :M
% % W(:,i) = W(:,i) / norm(W(:,i) );
% % end
% k=k+1
% F3=norm(W-W0,'fro')
% end;
% % W(:,i) = W(:,i) / norm(W(:,i) );
% % end
% 


z=W'*allsamples';
accu=0;
for i=1:10
    for j=6:10
        a=imread(strcat('D:\yaleface\',num2str(i),'\s',num2str(j),'.bmp'));
        a=imresize(a,(100*tt)^2);
        b=a(1:(100*tt)^2);
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