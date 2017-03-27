clear;
load('dbworld_subjects.mat');	
 fea0=inputs;
 gnd0=labels;


idx = find(gnd0==0);
A0=fea0(idx,:);


idx = find(gnd0==1);
A1=fea0(idx,:);

fea=[A0;A1]



gnd=sort(gnd0,1);