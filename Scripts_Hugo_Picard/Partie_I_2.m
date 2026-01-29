clear;
close all;
clc;

%% Partie I.2

K = 1000;


x = randn(2, K);

mx = [0;0];
Rx = [1 0;0 1];

figure;
plot(x(1,:), x(2,:),'.');
axis equal;
grid on;
hold on;



eta_list = [0.9 0.99 0.999];
couleurs=['b','r','k'];
for n=1:3
    trace_ellipse(mx, Rx, eta_list(n), couleurs(n));

end
legend("x","0.9","0.99","0.999")


%% Partie I.3
my = [2 ; 3];
Ry = [2 1;1 4];

A = chol(Ry,'lower');
b=my;
y = (A * x) + b;   
disp("y")
disp(y)
figure;
plot(y(1,:), y(2,:), '.');
axis equal; grid on; hold on;
title('Méthode Cholesky');
trace_ellipse(mean(y,2), cov(y.'), 0.9,'r');
trace_ellipse(mean(y,2), cov(y.'), 0.99,'g');
trace_ellipse(mean(y,2), cov(y.'), 0.999,'b');
hold off;
legend("x","0.9","0.99","0.999");

%% Partie I.4

y2 = (mvnrnd(my, Ry, K)).';
disp(y2)

figure;
subplot(1,2,1);
plot(y(1,:), y(2,:), '.');
axis equal; grid on; hold on;
title('Méthode Cholesky');
trace_ellipse(mean(y,2), cov(y.'), 0.9,'r');
trace_ellipse(mean(y,2), cov(y.'), 0.99,'r');

subplot(1,2,2);
plot(y2(1,:), y2(2,:), '.');
axis equal; grid on; hold on;
title('Méthode mvnrnd');
trace_ellipse(mean(y2,2), cov(y2.'), 0.9,'r');
trace_ellipse(mean(y2,2), cov(y2.'), 0.99,'r');


%% Partie I.5

my = [2 ; 3];
Ry = [2 -1;-1 4];

A = chol(Ry,'lower');
b=my;
y = (A * x) + b;   
disp("y")
disp(y)
figure;
plot(y(1,:), y(2,:), '.');
axis equal; grid on; hold on;
title('Méthode Cholesky');
trace_ellipse(mean(y,2), cov(y.'), 0.9,'r');
trace_ellipse(mean(y,2), cov(y.'), 0.99,'g');
trace_ellipse(mean(y,2), cov(y.'), 0.999,'b');
hold off;
legend("x","0.9","0.99","0.999");

