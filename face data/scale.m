clear;
load('YaleB_32x32.mat')

%Nomalize each vector to unit
%===========================================
% [nSmp,nFea] = size(fea);
% for i = 1:nSmp
%      fea(i,:) = fea(i,:) ./ max(1e-12,norm(fea(i,:)));
% end
%===========================================
%Scale the features (pixel values) to [0,1]
%===========================================
maxValue = max(max(fea));
fea = fea/maxValue;
%===========================================