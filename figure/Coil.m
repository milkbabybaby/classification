clear;
clc;
x1=[2,4,6,8,10,12,14,16,18]
x2=[2,4,6,8,10,12,14,16,18,20,25,30,35,40,45,50,55,60,65,70];


y1=[49.72,66.39,79.31,81.25,81.25,82.78,84.03,82.08,82.92];
y2=[60.14,76.94,83.33,85,86.52,88.06,86.39,86.53,86.39,86.67,88.19,87.22,88.89,89.17,88.47,88.19,87.78,87.64,87.22,87.22]

y20=[60.97,76.25,78.19,81.67,84.03,85,86.39,85.97,85.69,85.56,85.97,84.31,84.03,84.17,84.03,83.47,83.47,83.19,84.17,83.33]
    
y3=[49.72,66.39,79.31,81.25,81.25,82.78,84.03,82.08,82.92,82.78,83.06,82.78,84.44,85.14,85.42,85,84.58,85.14,85.28,86.67]


y4=[70.69,84.03,92.08,93.83,93.97,93.78,93.93,93.78,94.08,94.19,93.87,94.05,94.03,94.05,93.83,93.75,93.71,93.78,93.63,93.47]
y5=[75.06,88.75,92.43,94.13,94.17,94.19,93.97,94.03,94.17,94.20,94.08,94.11,94.11,94.17,94.25,94.25,94.22,94.05,94.19,94.22]
figure(1)
plot(x1,y1,'r*-.','LineWidth',1.5,'markersize',8);
hold on;
plot(x2,y2,'mx-.','LineWidth',1.5,'markersize',8);
hold on
plot(x2,y20,'cs--','LineWidth',1.5,'markersize',8);
hold on
plot(x2,y3,'ko-','LineWidth',1.5,'markersize',8);
hold on
plot(x2,y4,'b>--','LineWidth',1.5,'markersize',7);
hold on
plot(x2,y5,'g+:','LineWidth',1.5,'markersize',8);
hold on
% xlabel('Number of extracted features','FontName','Times New Roman');
% ylabel('Classification accuracy rate','FontName','Times New Roman');

xlabel('Number of extracted features','FontName','Arial','FontSize',11,'FontWeight','Bold');
ylabel('Classification accuracy rate','FontName','Arial','FontSize',11,'FontWeight','Bold');

legend('LDA','PCA','SLLE','GLDA-TRA','BFE','LSBFE',0)
set(gca,'FontName','Arial','FontWeight','Bold')

set(gca,'LineWidth',1.5)

myzoom([0.22,0.18,0.42,0.2],[10,70,93,95])
export_fig COIL_re.eps -painters -transparent