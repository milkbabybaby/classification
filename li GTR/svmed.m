clc;
clear;
load fisheriris
xdata = meas(51:end,3:4);
group = species(51:end);
svmStruct = svmtrain(xdata,group,'showplot',true);

classes = svmclassify(svmStruct,xdata,'showplot',true);

%����δ֪�Ĳ��Լ����з���Ԥ��,�����ͼ:



classperf(cp,classes,test);
cp.CorrectRate
