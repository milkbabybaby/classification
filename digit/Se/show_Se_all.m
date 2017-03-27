%Yale_B
%The face image can be displayed in matlab with the following command lines:
%===========================================
clear all;
clc;
load('semeion_all');
faceW = 16; 
faceH = 16;
faceW0= 12; 
faceH0= 12; 
numPerLine = 30 
ShowLine = 20; 

Y = zeros(faceH0*ShowLine,faceW0*numPerLine); 
for i=0:ShowLine-1 
  	for j=0:numPerLine-1 
    	I = reshape(fea_tr(i*numPerLine+j+1,:),[faceH,faceW]); 
        
        I=imresize(I',0.75);
         level=graythresh(I);   % Í¼Ïñ»Ò¶È´¦Àí
      I =im2bw(I,level);
        Y(i*faceH0+1:(i+1)*faceH0,j*faceW0+1:(j+1)*faceW0)=I;
  	end 
end 


imagesc(Y);
%imshow(Y);
colormap(gray);
axis equal;
axis off;

export_fig SE_ex -eps  -transparent 