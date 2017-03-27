%%f=trace(X'*A*X) df/dX=AX+A'X
%%(df/dX)_ij/dX'_mn=delta_jm*A_in+delta_jm*A_ni

clear;  
clc;
A=[7 2 3 4; 2 8 6 7; 3 6 11 9; 4 7 9 10 ]; % A is positive definite
 %A=[zeros(1,4-1)  0; eye(4-1) zeros(4-1,1)]
I=eye(3,3);

M=zeros(4,4,3,3);
for i=1:4 
    for j= 1:3
        for m =1:3 
            for n=1:4 
                M(i,n,m,j)=I(j,m)*A(i,n)+I(j,m)*A(n,i); % change the order i j m n into i n m j to avoid "squeeze" tensor in the following operations since M(:,:,:,1) is three order while M(:,1,:,:) is four order 
            end
        end
    end
end

%QQ=[];
% for j=1:3;
% QQ=cat(2,QQ,M(:,:,:,j));
% end

QQ=[];
for j=1:3;
QQ=[QQ; M(:,:,:,j)] % combine three order tensor in the i direction, then the first "block row" is j=1, the second "block row" is j=2 
end

QQQ=[];
for m=1:3;
QQQ=[QQQ QQ(:,:,m)] %combine matrix in the n direction, then the first " block column" is m=1, the second " block column" is m=2 
end


X=randi(10,4,3);

X1=X;

XX=reshape(X,12,1)  %reshape X into a vector 

Iterations=20;
Cost1=zeros(Iterations,1);
Cost2=zeros(Iterations,1);

for i=1:Iterations 
    
    %  Newton method 
    Cost1(i)=trace(X'*A*X); 
    P=A*X+A'*X;       
    PP=reshape(P,12,1); %reshape first order derivative into a vetor 
    XX=XX-inv(QQQ)*PP;  % update XX
    X=reshape(XX,4,3);  % reshape vector XX into a matrix X
    
    
    
    % Gradient  method 
    Cost2(i)=trace(X1'*A*X1);
    P1=A*X1+A'*X1;  
    X1=X1-0.02*P1;      
    
    
end 
 
figure(1)
plot(Cost1(1:Iterations),'r-*')

figure(2)
plot(Cost2(1:Iterations),'r-*')
    
