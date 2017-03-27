clear;
clc;
x1=[0.0001,0.001,0.01,0.1,1,3.162,10,31.62,100,1000,10000]

y1=[88.0556,87.7778,87.9167,89.1667,92.9167,93.8889,92.6389,87.5,83.4722,79.4444,79.0278];

figure(1)

plot(x1,y1,'b-','LineWidth',1.5);

axis([0 10000 0 100])
set(gca,'xscale','log')
% set(gca, 'ylim', [0, 100])
% set(gca, 'xlim', [0, 1000])

xlabel('mu','FontName','Arial','FontSize',11,'FontWeight','Bold');
ylabel('Classification accuracy rate','FontName','Arial','FontSize',11,'FontWeight','Bold');

set(gca,'LineWidth', 1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')

%myzoom([0.22,0.18,0.42,0.2],[10,70,83,95])

export_fig coil_u.eps -painters -transparent