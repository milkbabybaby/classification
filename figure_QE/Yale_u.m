clear;
clc;
x1=[0.0001,0.001,0.01,0.1,1,3.1622,10,31.62,100,1000,10000]

y1=[81.67,80,81.67,81.67,81.67,88.33,91.667,90.55,78.33,71.67,63.33];

figure(1)

plot(x1,y1,'b-','LineWidth',1.5);

axis([0 10000 0 100])
set(gca,'xscale','log')
% set(gca, 'ylim', [0, 100])
% set(gca, 'xlim', [0, 1000])
xlabel('mu','FontName','Arial','FontSize',11,'FontWeight','Bold');
ylabel('Classification accuracy rate','FontName','Arial','FontSize',11,'FontWeight','Bold');

%legend('line')
set(gca,'LineWidth', 1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')

export_fig yale_u.eps -painters -transparent