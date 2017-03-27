%pca+lda.m
%pca人脸识别，识别率88%
% a=imread('D:\code1 - 副本\face\orl\orl\orl001.bmp');
% [m,n]=size(a);
%  allsamples=[];
%  for i=1:10
%      for j=1:5
%          a=imread(strcat('D:\code1 - 副本\face\orl\orl',num2str(i),'\orl',num2str(j),'.bmp'));
%          %imshow(a);
%          b=a(1:m*n);
%         b=double(b);
%         allsamples=[allsamples;b];
%     end
% end

clear all;


m=10
c=40

% train_num=7;
%  train_num=6;
   train_num=5;

test=m-train_num;
N=c*train_num;
N1=N;

cha_jieguo=zeros(N,N);
K=zeros(N);

start_number=10;
end_number=c*train_num;

folder='orl\orl';
linshi0=imread('orl\orl001.bmp');
[row col]=size(linshi0);

for i=1:c
    for k=1:m
        filename=[folder num2str((i-1)*m+k,'%03d')  '.bmp'];
        input0(i,k,:,:)=imread(filename);
        aa=input0(i,k,:,:);
        aa=double(aa);
         fea(k,:,i)=aa(1:row*col);
        
    end
end
input0=double(input0);
