function f = myfun2(W,S,B)

%                                                   

L=S*W+W*B;
 

f=norm(L,'fro');

    
return;