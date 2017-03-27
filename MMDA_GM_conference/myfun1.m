function f = myfun1(W,S,B)

%                                                   

 L=S*W+W*B;
[m1,n1]=size(L);
f0=zeros(1,n1);
 f=0;
for i=1:n1
   
f0(i)=L(:,i)'*L(:,i);
f=f+f0(i);
end

    
return;