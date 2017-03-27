clear;
clc;
x1=[2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38]
x2=[2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,45,50,55,60,65,70]


y1=[42.5,77.5,83,89,91.5,93.5,92.5,94,93,94,95,95,94,93.5,93.5,94,93.5,93.5,93.5];
y2=[16,41.5,57.5,68,78,80,83.5,83,83.5,85,84,85.5,86.5,86,86,87.5,87.5,86.5,87.5,87.5,88,88,87.5,87.5,88,88.5]

y20=[42.5,58.75,68.75,77.5,80,82.5,83.75,83.75,83.75,81.25,82.5,83.75,86.25,87.5,85,86.25,86.25,87.5,86.25,86.25,87.5,88.75,88.75,87.5,90,90]


y3=[42.5,77.5,83,89,91.5,93.5,92.5,94,93,94,95,95,94,93.5,93.5,94,93.5,93.5,93.5,94.5,95,94.5,96,96,94.5,93.5]

%y4=[48,78.5,87.50,90.20,92.4,94,94.5,95,94.5,95.5,95,95,95,95,95,95,95,95,95,95.5,94.5,95,94.5,95,95,95]
y4=[48,78.5,87.50,90.20,92.4,93.7,94.0,94.5,94.3,94.8,94.6,94.6,94.8,94.6,94.6,94.6,94.7,94.7,94.8,94.9,94.5,94.8,94.5,94.3,94.3,95]
y5=[46,76.0,88.00,90.40,93.0,94.0,94.3,94.5,94.5,94.8,94.7,94.6,94.8,95.1,94.7,94.8,94.9,94.8,95.2,95.0,95.3,95.3,95.7,95.6,96,95.8]
figure(4)
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
hold on,
legend('LDA','PCA','SLLE','GLDA-TRA','BFE','LSBFE',0)

% xlabel('Number of extracted features','FontName','Times New Roman');
% ylabel('Classification accuracy rate','FontName','Times New Roman');

xlabel('Number of extracted features','FontName','Arial','FontSize',11,'FontWeight','Bold');
ylabel('Classification accuracy rate','FontName','Arial','FontSize',11,'FontWeight','Bold');
set(gca,'LineWidth', 1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')

myzoom([0.24,0.18,0.37,0.18],[44,70,94,96.5])

hold on;
%myzoom([0.42,0.46,0.47,0.25],[13,41,93.5,95.5])
myzoom([0.42,0.5,0.47,0.23],[13,41,93.5,95.5])

export_fig ORL_re.eps -painters -transparent