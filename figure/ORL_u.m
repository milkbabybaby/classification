clear;
clc;
x1=[0.0001,0.001,0.01,0.1,1,10,100,1000,10000]

y1=[88,88,88,88,92,94,88,73.5,73.5];

figure(1)

plot(x1,y1,'b-');

axis([0 10000 0 100])
set(gca,'xscale','log')
% set(gca, 'ylim', [0, 100])
% set(gca, 'xlim', [0, 1000])
xlabel('u');
ylabel('Classification accuracy rate');
grid
