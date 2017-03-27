clc;
clear;
load fisheriris
xdata = meas(51:end,3:4);
group = species(51:end);
svmStruct = svmtrain(xdata,group,'showplot',true);

classes = svmclassify(svmStruct,xdata,'showplot',true);

%对于未知的测试集进行分类预测,结果如图:



classperf(cp,classes,test);
cp.CorrectRate
