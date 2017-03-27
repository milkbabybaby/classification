
close all
clc;
clear;

load('iter.mat');
figure(1)
plot(Cost1(1110:2109),'r-*','LineWidth',1,'markersize',2)
% plot(Cost1(1110:1609),'r-*','LineWidth',1,'markersize',5)
% hold on
% plot(Cost1(1610:2109),'r-*','LineWidth',1,'markersize',5)

xlabel('Iteration number','FontName','Arial','FontSize',11,'FontWeight','Bold');
ylabel('The value of cost function','FontName','Arial','FontSize',11,'FontWeight','Bold');

set(gca,'LineWidth', 1.5,'FontName','Arial','FontSize',10,'FontWeight','Bold')

%myzoom([0.4,0.3,0.45,0.55],[16,33,4500,6700])
