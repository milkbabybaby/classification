
%The face image can be displayed in matlab with the following command lines:
%===========================================
clear all;
clc;
load('2k2k');
% faceW = 28; 
% faceH = 28;
% numPerLine = 30
% ShowLine = 10; 
% 
% Y = zeros(faceH*ShowLine,faceW*numPerLine); 
% for i=0:ShowLine-1 
%   	for j=0:numPerLine-1 
%     	
%        I=reshape(fea_tr(i*(numPerLine+176)+j+1,:),[faceH,faceW]);
%         Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW)=I';
%   	end 
% end 
% 
% 
% imagesc(Y);
% %imshow(Y);
% colormap(gray);
% axis equal;
% axis off;

%===========================================
idx = randperm(4000);
fea = fea(idx(1:100),:);

faceW = 28; 
faceH = 28; 
numPerLine = 20; 
ShowLine = 4; 

Y = zeros(faceH*ShowLine,faceW*numPerLine); 
for i=0:ShowLine-1 
  	for j=0:numPerLine-1 
    	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW])'; 
  	end 
end 

imagesc(Y);colormap(gray);

imshow(Y);
export_fig Mnist_ex2 -eps  -transparent 

%===========================================