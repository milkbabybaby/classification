clear
N=5,
M=5,
B=rand(N,N);
I=rand(N,N)
B=B'*B;

A=rand(N,M)
%+rand(N,M)*i
iterations=6000
Cost1=zeros(iterations,1);
v=0.1
for ii=1:iterations
 F= B*A;
 
 
% A=A-v*F;
% A=(sqrt((N)/trace(A'*A)))*A; 

% 
A1=A-v*(I-A*A')*F/norm(F);


A=sqrt(real(trace(A1'*A1))/real(trace(A1'*A1*A1'*A1)))*A1;

Cost1(ii)=trace(A'*B*A);
ii
end
A'*A-I