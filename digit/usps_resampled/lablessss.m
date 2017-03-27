
 clc;
 clear;
 
 
  load usps_resampled.mat
 IND1 = train_labels(1,:) == 1; 
 train_1 = train_patterns(:,IND1)';
 
  IND2 = train_labels(2,:) == 1; 
 train_2 = train_patterns(:,IND2)';
 
  IND3 = train_labels(3,:) == 1; 
 train_3 = train_patterns(:,IND3)';
 
 IND4 = train_labels(4,:) == 1; 
 train_4 = train_patterns(:,IND4)';
 
 IND5 = train_labels(5,:) == 1; 
 train_5 = train_patterns(:,IND5)';
 
 IND6 = train_labels(6,:) == 1; 
 train_6 = train_patterns(:,IND6)';
 
 IND7 = train_labels(7,:) == 1; 
 train_7 = train_patterns(:,IND7)';
 
 IND8 = train_labels(8,:) == 1; 
 train_8 = train_patterns(:,IND8)';
 
 IND9 = train_labels(9,:) == 1; 
 train_9 = train_patterns(:,IND9)';
 
 IND10 = train_labels(10,:) == 1; 
 train_10 = train_patterns(:,IND10)';
 
lab_tr = [ones(sum(IND1),1); 2*ones(sum(IND2),1);3*ones(sum(IND3),1);4*ones(sum(IND4),1);5*ones(sum(IND5),1);6*ones(sum(IND6),1);7*ones(sum(IND7),1);8*ones(sum(IND8),1);9*ones(sum(IND9),1);10*ones(sum(IND10),1)];

% x=[1;2;3;4;5;6;7;8;9;10];
% 
% lab_te=[];
% for i=1:4649
%     IND = train_labels(:,i) == 1; 
%     lab_te=[lab_te;x(IND)];
% end
% 
 fea_tr=[train_1;train_2;train_3;train_4;train_5;train_6;train_7;train_8;train_9;train_10];
% fea_te=test_patterns';

 ND1 = test_labels(1,:) == 1; 
 test_1 = test_patterns(:,ND1)';
 

 ND2 = test_labels(2,:) == 1; 
 test_2 = test_patterns(:,ND2)';
 

 ND3 = test_labels(3,:) == 1; 
 test_3 = test_patterns(:,ND3)';

 ND4 = test_labels(4,:) == 1; 
 test_4 = test_patterns(:,ND4)';
 

 ND5 = test_labels(5,:) == 1; 
 test_5 = test_patterns(:,ND5)';

 ND6 = test_labels(6,:) == 1; 
 test_6 = test_patterns(:,ND6)';;
 

 ND7 = test_labels(7,:) == 1; 
 test_7 = test_patterns(:,ND7)';
 

 ND8 = test_labels(8,:) == 1; 
 test_8 = test_patterns(:,ND8)';
 

 ND9 = test_labels(9,:) == 1; 
 test_9 = test_patterns(:,ND9)';
 

 ND10 = test_labels(10,:) == 1; 
 test_10 = test_patterns(:,ND10)';
 
lab_te = [ones(sum(ND1),1); 2*ones(sum(ND2),1);3*ones(sum(ND3),1);4*ones(sum(ND4),1);5*ones(sum(ND5),1);6*ones(sum(ND6),1);7*ones(sum(ND7),1);8*ones(sum(ND8),1);9*ones(sum(ND9),1);10*ones(sum(ND10),1)];
 fea_te=[test_1;test_2;test_3;test_4;test_5;test_6;test_7;test_8;test_9;test_10];