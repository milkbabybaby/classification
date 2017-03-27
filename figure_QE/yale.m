clear;
clc;
x1=[2,4,6,8,10,12,14]
x2=[2,4,6,8,10,12,14,20,25,30,35,40,45,50,55,60,65,70,75,80];


y1=[40,66.67,73.33,76.67,83.33,85,90];
y2=[26.67,63.33,66.67,76.67,75,76.67,76.67,83.33,81.67,81.67,78.33,80,80,81.67,80,80, 81.67,81.67,81.67,80]

%y20=[26.67,55,56.67,56.67,63.33,66.67,70,73.33,75,75,75,75,71.67,73.33,80,73.33,75,78.33]

y3=[40,66.67,73.33,76.67,83.33,85,90,91.67,91.67,93.33,91.67,90,90,86.67,81.67,81.67,81.67,83.33,83.33,78.33]

y4=[48.33,65,78.33,86.67,88.33,90,90.33,91.67,91.67,93.33,93,93.33,92,93,92.67,93.33,94,94.67,94,94]
y5=[48.33,66.67,85,88.33,93.33,93.67,94,94,94.33,94.67,95,94.67,94.33,95,94.67,95,95,95.33,95,95.33]
figure(1)
plot(x1,y1,'r*-.','LineWidth',1.5,'markersize',8);
hold on
plot(x2,y2,'mx-.','LineWidth',1.5,'markersize',8);
hold on
%plot(x2,y20,'cs--','LineWidth',1.5,'markersize',8);
hold on
plot(x2,y3,'ko-','LineWidth',1.5,'markersize',8);
hold on
plot(x2,y4,'b>--','LineWidth',1.5,'markersize',7);
hold on
plot(x2,y5,'g+:','LineWidth',1.5,'markersize',8);
% xlabel('Number of extracted features','FontName','Times New Roman');
% ylabel('Classification accuracy rate','FontName','Times New Roman');

xlabel('Number of extracted features','FontName','Arial','FontSize',11,'FontWeight','Bold');
ylabel('Classification accuracy rate','FontName','Arial','FontSize',11,'FontWeight','Bold');
legend('LDA','PCA','GLDA-TRA','BFE','LSBFE',0)
%set(gca, 'LineWidth', 1.5);
set(gca,'LineWidth', 1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')

export_fig Yale_re.eps -painters -transparent