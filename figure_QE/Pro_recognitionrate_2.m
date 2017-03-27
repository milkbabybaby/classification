x2=[1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30];
x1=[1]
y1=[0.6508];
y2=[0.6508,0.6508, 0.6825,0.6825, 0.6984, 0.7143, 0.6984, 0.7025, 0.7025, 0.7143, 0.7143, 0.7460, 0.7460, 0.7937, 0.8254, 0.8254]
y3=[0.6349,0.6508, 0.6667,0.7302, 0.7302, 0.7460, 0.7460, 0.7619, 0.7619, 0.7619,0.7619, 0.7778, 0.7778, 0.8254, 0.8254, 0.8254]
figure(5)
plot(x1,y1,'r*');
hold on;
plot(x2,y2,'ko-');
hold on
plot(x2,y3,'b^--');
axis([0 30 0.5 0.9])
xlabel('Number of extracted features');
ylabel('Classification accuracy rate');
legend('LDA','GLDA-TRA','MMDA-GM',0)
export_fig Pro_re.eps -painters -transparent