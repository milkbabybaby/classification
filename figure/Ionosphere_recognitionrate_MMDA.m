x2=[1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30];
x1=[1]
y1=[90.03];
y2=[90.03,91.45,93.16,96.87,98.01,98.86,99.43,99.43,99.43,99.43,99.72,99.72,99.72,99.72,99.72,99.72]
y3=[90.03,93.16,96.01,99.15,99.43,99.72,99.72,99.72,99.72,99.72,99.72,99.72,99.72,99.72,99.72,99.72]
figure(1)

plot(x1,y1,'r*-.','LineWidth',1.5);
hold on;
plot(x2,y2,'ko-','LineWidth',1.5);
hold on
plot(x2,y3,'b^--','LineWidth',1.5);
% xlabel('Number of extracted features','FontName','Times New Roman');
% ylabel('Classification accuracy rate','FontName','Times New Roman');

xlabel('Number of extracted features');
ylabel('Classification accuracy rate');
legend('LDA','GLDA-TRA','BFE',0)
%set(gca, 'fontsize', 8);
%set(gca, 'XMinorTick', 'on');
%set(gca, 'XGrid', 'on');
%set(gca, 'LineWidth', 1.5);
%grid on

%print(gcf, '-depsc2', 'Example12.eps');