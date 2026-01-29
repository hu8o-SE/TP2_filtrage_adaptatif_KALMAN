clear;
close all;
clc;

K = 1000;
x = randn(2, K);

mz = [2 ; 3];
Rz = [2 -1 ; -1 4];

cho = chol(Rz,'lower');
z = cho * x + mz;

figure;
plot(z(1,:), z(2,:), '.');
axis equal;
grid on;
hold on;


my_2 = mean(z,2);
Ry_2 = cov(z.');

eta_list = [0.9 0.99 0.999];
for eta = eta_list
    trace_ellipse(my_2, Ry_2, eta,'r');
end
