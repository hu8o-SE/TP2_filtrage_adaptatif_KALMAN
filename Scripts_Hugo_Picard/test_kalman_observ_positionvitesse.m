clear all; close all; clc;

Te = 1;

F = [1 Te;
     0 1];

C = eye(2);

x1 = [0 ; 50/3.6];
v1 = x1(2);

T = 100;

x_prio_1 = x1;
P_prio_1 = 10*eye(2);

RSB_etat   = 25;
RSB_mesure = 40;

sigma_u = v1 * 10^(-RSB_etat/20);
sigma_w = v1 * 10^(-RSB_mesure/20);

Ru = diag([sigma_u^2 sigma_u^2]);
Rw = diag([sigma_w^2 sigma_w^2]);

[x_list, y_list] = creation_etat_obs(F, C, Ru, Rw, x1, T);

[G_list, x_post_list, P_post_list, x_prio_list, P_prio_list] = ...
    filtre_kalman(x_prio_1, P_prio_1, y_list, F, C, Ru, Rw);

x_prio_list = x_prio_list(:,1:T);
P_prio_list = P_prio_list(:,:,1:T);

n = 1:T;

figure;

subplot(211);
plot(n, x_list(1,:), 'k+', n, y_list(1,:), 'g*', ...
     n, x_prio_list(1,:), 'bo', n, x_post_list(1,:), 'rx');
legend('position vraie','position observée','estimée a priori','estimée a posteriori');
xlabel('temps en secondes'); ylabel('position en mètres');
title('Position');

subplot(212);
plot(n, x_list(2,:), 'k+', n, y_list(2,:), 'g*', ...
     n, x_prio_list(2,:), 'bo', n, x_post_list(2,:), 'rx');
legend('vitesse vraie','vitesse observée','estimée a priori','estimée a posteriori');
xlabel('temps en secondes'); ylabel('vitesse en m/s');
title('Vitesse');

figure;

subplot(211);
plot(n, x_list(1,:)-y_list(1,:), 'g*', ...
     n, x_list(1,:)-x_prio_list(1,:), 'bo', ...
     n, x_list(1,:)-x_post_list(1,:), 'rx');
legend('bruit mesure position','erreur position a priori','erreur position a posteriori');
xlabel('temps en secondes'); ylabel('mètres');

subplot(212);
plot(n, x_list(2,:)-y_list(2,:), 'g*', ...
     n, x_list(2,:)-x_prio_list(2,:), 'bo', ...
     n, x_list(2,:)-x_post_list(2,:), 'rx');
legend('bruit mesure vitesse','erreur vitesse a priori','erreur vitesse a posteriori');
xlabel('temps en secondes'); ylabel('m/s');

P_prio_11 = squeeze(P_prio_list(1,1,:));
P_prio_22 = squeeze(P_prio_list(2,2,:));
P_post_11 = squeeze(P_post_list(1,1,:));
P_post_22 = squeeze(P_post_list(2,2,:));

figure;

subplot(211);
plot(n, P_prio_11, 'b', n, P_post_11, 'r');
legend('P a priori (1,1)','P a posteriori (1,1)');
xlabel('temps en secondes');
title('Variance sur la position');

subplot(212);
plot(n, P_prio_22, 'b', n, P_post_22, 'r');
legend('P a priori (2,2)','P a posteriori (2,2)');
xlabel('temps en secondes');
title('Variance sur la vitesse');

figure;
hold on; grid on; axis equal;
title('estimées a priori / a posteriori + ellipses à 0.9 de confiance');
xlabel('x_1'); ylabel('x_2');

plot(x_prio_list(1,:), x_prio_list(2,:), 'bo');
plot(x_post_list(1,:), x_post_list(2,:), 'rx');

figure;
hold on; grid on; axis equal;
title('Estimées + ellipses (eta = 0.9) à certains instants');
xlabel('x_1 (position)'); ylabel('x_2 (vitesse)');

eta = 0.9;

instants = [1 2 3 10 20 30 50 100];
colors   = {'r','g','b','c','m','y','k','w'};

for i = 1:length(instants)
    k = instants(i);
    col = colors{i};

    plot(x_list(1,k), x_list(2,k), '+', 'Color', col, 'MarkerSize', 8, 'LineWidth', 1.5);
    plot(x_prio_list(1,k), x_prio_list(2,k), 'o', 'Color', col, 'MarkerSize', 6, 'LineWidth', 1.2);
    plot(x_post_list(1,k), x_post_list(2,k), 'x', 'Color', col, 'MarkerSize', 6, 'LineWidth', 1.2);

    trace_ellipse(x_prio_list(:,k), P_prio_list(:,:,k), eta, [col '--']);
    trace_ellipse(x_post_list(:,k), P_post_list(:,:,k), eta, [col '-']);
end

legend('vrai état (+)','a priori (o)','a posteriori (x)', 'Location','best');
hold off;
