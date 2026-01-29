
clear;
close all;
clc;

K = 1000;

m = [2 3];
R = [2 1 ; 1 4];

x = randn(K,2);              
cho = chol(R,'lower');
y1 = (cho * x.').' + m;        

y2 = mvnrnd(m, R, K);

figure;
subplot(1,2,1);
plot(y1(:,1), y1(:,2), '.');
axis equal; grid on; hold on;
title('Méthode Cholesky');
trace_ellipse(mean(y1).', cov(y1), 0.9,'r');
trace_ellipse(mean(y1).', cov(y1), 0.99,'r');

subplot(1,2,2);
plot(y2(:,1), y2(:,2), '.');
axis equal; grid on; hold on;
title('Méthode mvnrnd');
trace_ellipse(mean(y2).', cov(y2), 0.9,'r');
trace_ellipse(mean(y2).', cov(y2), 0.99,'r');


disp(mean(y2));
disp(cov(y2));
