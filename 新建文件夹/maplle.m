
function [Y2] = maplle(X_tr,X_te,K,Y)

[D,N1] = size(X_tr);
[D,N2] = size(X_te);


X1 = sum(X_tr.^2,1);
X2 = sum(X_te.^2,1);
distance = repmat(X2,N1,1)+repmat(X1',1,N2)-2*X_tr'*X_te;


[sorted,index] = sort(distance);
neighborhood = index(1:K,:);



% STEP2: SOLVE FOR RECONSTRUCTION WEIGHTS

if(K>D) 
 
  tol=1e-3; % regularlizer in case constrained fits are ill conditioned
else
  tol=0;
end;
tol=1e-3;
W = zeros(K,N2);
for ii=1:N2
   z = X_tr(:,neighborhood(:,ii))-repmat(X_te(:,ii),1,K); % shift ith pt to origin
   C = z'*z;                                        % local covariance
   C = C + eye(K,K)*tol*trace(C);                   % regularlization (K>D)
   W(:,ii) = C\ones(K,1);                           % solve Cw=1
   W(:,ii) = W(:,ii)/sum(W(:,ii));                  % enforce sum(w)=1
  Y2(:,ii)=Y(:,neighborhood(:,ii))*W(:,ii);
end;




