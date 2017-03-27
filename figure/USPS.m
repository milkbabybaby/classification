clear;
x0=[1,2,3,4,5,6,7,8]
x1=[2,4,6,8]
x2=[2,4,6,8,10,15,20,25,30,35,40,45,50,55,60,65,70];


y1=[59.13,82.37,88.57,90.73];
%y2=[33.67,54.03,78.7,86.9,89.86,93.7,95.06,95.86,95.76,95.96,96.13,96.03,95.8,95.8,95.7,95.7,95.6]
y3=[37.53,41.67,46.37,64.53,70.33,77.4,84.1,85.77,86.9,89.37,91.67,92.47,92.5,92.7,92.5,93.03,93.17]
y4=[55.27,81.18,88.7,91.47,92.77,93.53,94.53,95.27,95.23,95.37,95.53,95.9,96.07,96.2,96.33,96.17,96.27]
figure(1)
plot(x1,y1,'r*-.','LineWidth',1.5);
hold on;
%plot(x2,y2,'ms-.','LineWidth',1.5);
hold on
plot(x2,y3,'ko-','LineWidth',1.5);
hold on
plot(x2,y4,'b>--','LineWidth',1.5);
hold on
%plot(x2,y5,'g+:','LineWidth',1.5);
% xlabel('Number of extracted features','FontName','Times New Roman');
% ylabel('Classification accuracy rate','FontName','Times New Roman');

xlabel('Number of extracted features');
ylabel('Classification accuracy rate');
legend('LDA','PCA','GLDA-TRA','BFE','LSBFE',0)
%set(gca, 'LineWidth', 1.5);

export_fig test.eps -painters -transparent
