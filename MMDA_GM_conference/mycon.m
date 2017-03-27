function [c,ceq]=mycon(W)
ceq=W'*W-eye(size(W));
c=[];
return;