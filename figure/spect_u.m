clear;%m=14
clc;
x1=[0.0001,0.001,0.01,0.1,1,10,100,1000,10000]

y1=[0.8,0.9943,0.9943,0.9943,0.9972,0.9972,0.9972,0.9972,0.9972];

figure(1)

plot(x1,y1,'b-','LineWidth',1.5);

axis([0 10000 0.85 1])
set(gca,'xscale','log')
% set(gca, 'ylim', [0, 100])
% set(gca, 'xlim', [0, 1000])
xlabel('mu','FontName','Arial','FontSize',11);
ylabel('Classification accuracy rate','FontName','Arial','FontSize',11);

%legend('line')
%set(gca,'LineWidth', 1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')

export_fig spect_u.eps -painters -transparent