clear;
close all;
clc;

K = 1000;

m = [2 3];
R = [2 1 ; 1 4];

x = randn(K,2);              
cho = chol(R,'lower');
y = (cho * x.').' + m;        

figure;
plot(y(:,1), y(:,2), '.');
axis equal; grid on; hold on;
title('Méthode Cholesky');
trace_ellipse(mean(y).', cov(y), 0.9,'r');
trace_ellipse(mean(y).', cov(y), 0.99,'r');
hold off;