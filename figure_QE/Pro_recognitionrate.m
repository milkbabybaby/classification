x2=[1,4,8,12,16,20,24,28];
x1=[1]
y1=[0.6508];
y2=[0.6508,0.6825,0.6984,0.6984,0.7025,0.7143,0.7460,0.8254]
y3=[0.6349,0.6667,0.7302,0.7460,0.7619,0.7619,0.7778,0.8254]
figure(5)
plot(x1,y1,'r*');
hold on;
plot(x2,y2,'ko-');
hold on
plot(x2,y3,'b^--');
xlabel('Number of extracted features');
ylabel('Classification accuracy rate');
legend('LDA','GLDA-TRA','MMDA')
