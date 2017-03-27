clear all
clc
syms t;
A=[0 1;2 3]
B=[0;1];
tf=1

 digits(8)
 
WB=vpa(int(expm(A*t)*B*B'*expm(A'*t),t, 0, tf))
Xf=vpa(expm(A*tf)*expm(A'*tf))





 
% WB0=subs(WB,tf,tf0)=subs(WB,tf,tf0)
% Xf0=subs(Xf,tf,tf0)
% Xf0=vpa(Xf0)
C=inv(WB)
F=int(expm(A'*t)*C*Xf*C*expm(A*t),t,0,tf)*B


Iterations_number=30;
Cost=zeros(Iterations_number,1);
v=0.1;
Xf=vpa(expm(A*tf)*expm(A'*tf))
for k=1:Iterations_number
    
WB=vpa(int(expm(A*t)*B*B'*expm(A'*t),t, 0, tf));
C=inv(WB)
Cost(k)=trace(inv(WB)*Xf);
df=int(expm(A'*t)*C*Xf*C*expm(A*t),t,0,tf)*B;
Cost2(k)=norm(df);
    
    B=B+v*int(expm(A'*t)*C*Xf*C*expm(A*t),t,0,tf)*B
  k  
end

plot(Cost,'r-*')

figure(2)


plot(Cost2,'r-*')

