x2=[1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30];
x1=[1]
y1=[0.9003];
y2=[0.9003,0.9145,0.9316,0.9687,0.9801,0.9886,0.9943,0.9943,0.9943,0.9943,0.9972,0.9972,0.9972,0.9972,0.9972,0.9972]
y3=[0.9003,0.9031,0.9316,0.9744,0.9886,0.9943,0.9943,0.9972,0.9972,0.9972,0.9972,0.9972,1,1,1,1]
figure(4)
plot(x1,y1,'r*');
hold on;
plot(x2,y2,'ko-');
hold on
plot(x2,y3,'b^--');
xlabel('Number of extracted features');
ylabel('Classification accuracy rate');
legend('LDA','GLDA-TRA','MMDA',0)
export_fig Iono_re.eps -painters -transparent