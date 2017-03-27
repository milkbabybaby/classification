clear;
clc;
x1=[2,4,6,8]
x2=[2,4,6,8,10,15,20,25,30,35,40,45,50,55,60,65,70];
y1=[48.57,69.48,83.48,84.99];
y2=[40.47,63.07,79.76,85.67,88.19,90.21,90.72,91.73,91.73,91.39,91.9,91.23,91.73,91.73,91.56,91.9,92.07]
y3=[46.37,62.06,64.08,72.18,80.10,86.17,90.56,89.38,90.05,88.87,89.2,90.56,91.06,90.89,90.89,90.05,91.23]
y4=[53.96,74.54,86.68,91.06,91.57,91.06,92.24,92.24,92.92,92.92,93.09,93.93,94.27,94.44,94.27,94.27,94.27]
figure(1)
plot(x1,y1,'r*-.','LineWidth',1.5);
hold on;
plot(x2,y2,'ms-.','LineWidth',1.5);
hold on
plot(x2,y3,'ko-','LineWidth',1.5);
hold on
plot(x2,y4,'b>--','LineWidth',1.5);
hold on
plot(x2,y5,'g+:','LineWidth',1.5);
% xlabel('Number of extracted features','FontName','Times New Roman');
% ylabel('Classification accuracy rate','FontName','Times New Roman');

xlabel('Number of extracted features');
ylabel('Classification accuracy rate');
legend('LDA','PCA','GLDA-TRA','BFE','LSBFE',0)
%set(gca, 'LineWidth', 1.5);

export_fig test.eps -painters -transparent