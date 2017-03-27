clear all;
clc;
load('semeion_all');
for i=1:size(lab_tr)
    I=reshape(fea_tr(i,:),16,16);
  
   I=imresize(I',0.75);
          level=graythresh(I);   % 图像灰度处理
      I =im2bw(I,level);
      I=double(I);
        fea_tr0(i,:)=reshape(I,1,144);
end 


for i=10
   A0_tr(:,:,i)=fea_tr0((i-1)*100+1:i*100,:); 
end
for i=1:size(lab_te)
    I=reshape(fea_te(i,:),16,16);
  
   I=imresize(I',0.75);
          level=graythresh(I);   % 图像灰度处理
      I =im2bw(I,level);
       I=double(I);
   fea_te0(i,:)=reshape(I,1,144);
end 
