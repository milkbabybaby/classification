 clear all
 clc
 
digits(8)
A=rand(10,10);
B=rand(10,5);
tf=1
N=length(A);
M=5;
 WB0=zeros(N,N);
 F0=zeros(N,M);  
 
Xf=expm(A*tf)*expm(A'*tf);
 


ot=0.04;

N=length(A)


for k=1:1/ot
    WB0=WB0+expm(A*(ot*k))*B*B'*expm(A'*(ot*k));
end

 C=inv(WB0); 
 
for k=1:1/ot
 F0=F0+expm(A'*(ot*k))*C*Xf*C*expm(A*(ot*k))*B;
end
 
% WB0=subs(WB,tf,tf0)=subs(WB,tf,tf0)
% Xf0=subs(Xf,tf,tf0)
% Xf0=vpa(Xf0)

 


Iterations_number=5;
Cost=zeros(Iterations_number,1);
v=0.2;
Xf=vpa(expm(A*tf)*expm(A'*tf))
for k=1:Iterations_number
 WB0=zeros(N,N);
 F0=zeros(N,M); 
for k1=1:tf/ot
    WB0=WB0+expm(A*(ot*k1))*B*B'*expm(A'*(ot*k1));
end
 C=inv(WB0); 
for k1=1:tf/ot
 F0=F0+(expm(A'*(ot*k1))*C*Xf*C*expm(A*(ot*k1)))*B;
end
     
 
Cost(k)=trace(C*Xf);

Cost2(k)=norm(F0);
    
    B=B+v*F0
  k  
end

plot(Cost,'r-*')

figure(2)


plot(Cost2,'r-*')

