load fisheriris

%����matlab�Դ�������[�й����ݵ���Ϣ�����Լ���UCI����,����UCI�ľ�������֮һ],�õ�����������ͼ:


%����meas��150*4�ľ����������150������ÿ��������4����������,species��������150�������ķ���.

data = [meas(:,1), meas(:,2)];

%������ֻȡmeas�ĵ�һ�к͵ڶ���,��ֻѡȡǰ��������.

groups = ismember(species,'setosa');

%����species������������������:setosa,versicolor,virginica,Ϊ��ʹ�����,���ǽ����Ϊ����������:Setosa and non-Setosa.

[train, test] = crossvalind('holdOut',groups);
cp = classperf(groups);

%���ѡ��ѵ�����ϲ��Լ�[�й�crossvalind��ʹ�����Լ�helpһ��]
%����cp�����Ǻ����������۷�������.

svmStruct = svmtrain(data(train,:),groups(train),'showplot',true);

%ʹ��svmtrain����ѵ��,�õ�ѵ����ĽṹsvmStruct,��Ԥ��ʱʹ��.

%ѵ�������ͼ:



classes = svmclassify(svmStruct,data(test,:),'showplot',true);

%����δ֪�Ĳ��Լ����з���Ԥ��,�����ͼ:



classperf(cp,classes,test);
cp.CorrectRate

