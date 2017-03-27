%Yale_B
%The face image can be displayed in matlab with the following command lines:
%===========================================
clear all;
clc;
load('COIL20');
faceW = 32; 
faceH = 32; 
numPerLine = 10; 
ShowLine = 2; 

Y = 255*ones(faceH*ShowLine,faceW*numPerLine); 

for i=0:ShowLine-1 
  	for j=0:numPerLine-1 
    	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea((i*numPerLine+j)*72+1,:),[faceH,faceW]); 
  	end 
end 

% for i=0:ShowLine-1 
%   	for j=0:numPerLine-1 
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 

% for i=0
%   	for j=0:5
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 
% 
% for i=1 
%   	for j=0:4
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 

imagesc(Y);
%imshow(Y);
colormap(gray);

axis normal;
axis equal;
axis off;

export_fig coil_ex.eps -transparent

%===========================================