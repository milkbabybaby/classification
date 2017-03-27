clear;%m=5
clc;
x1=[0.0001,0.001,0.01,0.1,1,10,100,1000,10000]

y1=[0.619,0.6349,0.6508,0.6667,0.6825,0.6667,0.6508,0.6508,0.619];

figure(1)

plot(x1,y1,'b-','LineWidth',1.5);

axis([0 10000 0 1])
set(gca,'xscale','log')
% set(gca, 'ylim', [0, 100])
% set(gca, 'xlim', [0, 1000])
xlabel('mu','FontName','Arial','FontSize',11);
ylabel('Classification accuracy rate','FontName','Arial','FontSize',11);

%legend('line')
%set(gca,'LineWidth', 1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')

export_fig breast_u.eps -painters -transparent