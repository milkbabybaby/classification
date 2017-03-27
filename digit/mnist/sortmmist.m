clear;
clc;
load ('mnist_all.mat');
train0=double(train0);
train1=double(train1);
train2=double(train2);
train3=double(train3);
train4=double(train4);
train5=double(train5);
train6=double(train6);
train7=double(train7);
train8=double(train8);
train9=double(train9);

test0=double(test0);
test1=double(test1);
test2=double(test2);
test3=double(test3);
test4=double(test4);
test5=double(test5);
test6=double(test6);
test7=double(test7);
test8=double(test8);
test9=double(test9);

t0=size(train0,1);
t1=size(train1,1);
t2=size(train2,1);
t3=size(train3,1);
t4=size(train4,1);
t5=size(train5,1);
t6=size(train6,1);
t7=size(train7,1);
t8=size(train8,1);
t9=size(train9,1);


fea_tr=[train0;train1;train2;train3;train4;train5;train6;train7;train8;train9;];
fea_te=[test0;test1;test2;test3;test4;test5;test6;test7;test8;test9;];

lab_tr = [0*ones(t0,1);ones(t1,1); 2*ones(t2,1);3*ones(t3,1);4*ones(t4,1);5*ones(t5,1);6*ones(t6,1);7*ones(t7,1);8*ones(t8,1);9*ones(t9,1);];

tt0=size(test0,1);
tt1=size(test1,1);
tt2=size(test2,1);
tt3=size(test3,1);
tt4=size(test4,1);
tt5=size(test5,1);
tt6=size(test6,1);
tt7=size(test7,1);
tt8=size(test8,1);
tt9=size(test9,1);

lab_te = [0*ones(tt0,1);ones(tt1,1); 2*ones(tt2,1);3*ones(tt3,1);4*ones(tt4,1);5*ones(tt5,1);6*ones(tt6,1);7*ones(tt7,1);8*ones(tt8,1);9*ones(tt9,1);];