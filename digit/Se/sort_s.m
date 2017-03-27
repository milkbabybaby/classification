clear;
load('semeion.mat');	
 fea0=semeion(:,1:256);
 gnd=semeion(:,257:266);


idx = find(gnd(:,1)==1);
train_0=fea0(idx,:);


idx = find(gnd(:,2)==1);
train_1=fea0(idx,:);

idx = find(gnd(:,3)==1);
train_2 =fea0(idx,:);


idx = find(gnd(:,4)==1);
train_3=fea0(idx,:);


idx = find(gnd(:,5)==1);
train_4=fea0(idx,:);

idx = find(gnd(:,6)==1);
train_5=fea0(idx,:);

idx = find(gnd(:,7)==1);
train_6=fea0(idx,:);


idx = find(gnd(:,8)==1);
train_7=fea0(idx,:);


idx = find(gnd(:,9)==1);
train_8=fea0(idx,:);

idx = find(gnd(:,10)==1);
train_9=fea0(idx,:);


m0=size(train_0,1);
train0=train_0(1:100,:);
n0=m0-100;
test0=train_0(101:m0,:);

m1=size(train_1,1);
train1=train_1(1:100,:);
n1=m1-100;
test1=train_1(101:m1,:);


m2=size(train_2,1);
train2=train_2(1:100,:);
n2=m2-100;
test2=train_2(101:m2,:);

m3=size(train_3,1);
train3=train_3(1:100,:);
n3=m3-100;
test3=train_3(101:m3,:);

m4=size(train_4,1);
train4=train_4(1:100,:);
n4=m4-100;
test4=train_4(101:m4,:);

m5=size(train_5,1);
train5=train_5(1:100,:);
n5=m5-100;
test5=train_5(101:m5,:);

m6=size(train_6,1);
train6=train_6(1:100,:);
n6=m6-100;
test6=train_6(101:m6,:);

m7=size(train_7,1);
train7=train_7(1:100,:);
n7=m7-100;
test7=train_7(101:m7,:);

m8=size(train_8,1);
train8=train_8(1:100,:);
n8=m8-100;
test8=train_8(101:m8,:);

m9=size(train_9,1);
train9=train_9(1:100,:);
n9=m9-100;
test9=train_9(101:m9,:);

fea_tr=[train0;train1;train2;train3;train4;train5;train6;train7;train8;train9;];
fea_te=[test0;test1;test2;test3;test4;test5;test6;test7;test8;test9;];

lab_tr=[0*ones(100,1);ones(100,1);2*ones(100,1);3*ones(100,1);4*ones(100,1);5*ones(100,1);6*ones(100,1);7*ones(100,1);8*ones(100,1);9*ones(100,1);];
lab_te=[0*ones(n0,1);ones(n1,1); 2*ones(n2,1);3*ones(n3,1);4*ones(n4,1);5*ones(n5,1);6*ones(n6,1);7*ones(n7,1);8*ones(n8,1);9*ones(n9,1);];
