clear;
load('USPS.mat');	
gnd = gnd - 1;

%Pick a query point with digit '2'
digit = 2;
idx = find(gnd == digit);
queryIdx = idx(10);
nSmp = size(fea,1);
y0 = zeros(nSmp,1);
y0(queryIdx) = 1;

%Ranking with Euclidean distance 
D = EuDist2(fea(queryIdx,:),fea);
[dump,idx]=sort(D);
showfea = fea(idx(2:100),:);
Y = ones(160,160)*-1;
Y(1:16,4*16+1:5*16) = reshape(fea(queryIdx,:),[16,16])'; %'
for i=1:9
  for j=0:9
    Y(i*16+1:(i+1)*16,j*16+1:(j+1)*16) = reshape(showfea((i-1)*10+j+1,:),[16,16])'; %'
  end
end
imagesc(Y);colormap(gray);