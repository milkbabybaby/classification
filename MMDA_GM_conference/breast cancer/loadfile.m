clear;
clc;
AA= load('Original.txt')
A=sortrows(AA,11);
fea=A(:,2:10)
lab=A(:,9)
