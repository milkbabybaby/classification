%clear;
%tt=0.15;
a=imread('D:\yaleface\1\s1.bmp');
 a=imresize(a,[40,40]);

[m,n]=size(a);
allsamples=[];
for i=1:15
    for j=1:11
        a=imread(strcat('D:\yaleface\',num2str(i),'\s',num2str(j),'.bmp'));
       a=imresize(a,[40,40]);
        %imshow(a);
     
        b=a(1:m*n);
        b=double(b);
        allsamples=[allsamples;b];
    end
end
[m1,n1]=size(allsamples);


u=mean(allsamples);