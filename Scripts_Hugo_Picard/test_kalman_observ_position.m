clear all; close all;

% Test de la fonction filtre_kalman quand seule la position est observée
%------------------------------------------------------------------------

Te = 1;

F = [1 Te; 
     0 1];                 % A compléter

C = [1 0];                 % A compléter (on observe uniquement la position)

x1 = [0 ; 50/3.6];             % A compléter : position initiale 0 m, vitesse initiale 50 m/s
v1 = x1(2);

T = 100;                   % nombre total d'instants (correspondant au nombre d'observations)

% Initialisations de l'algorithme
x_prio_1 = x1;
P_prio_1 = 10*eye(2);

% Choix des RSB (exemple : faible bruit état + faible bruit mesure)
RSB_etat   = 50;           % A compléter
sigma_u2   = v1 * 10^(-RSB_etat/20);   % A compléter
sigma_u1   = sigma_u2;                 % A compléter (même bruit sur les 2 composantes)
Ru         = diag([sigma_u1^2 sigma_u2^2]);  % A compléter

RSB_mesure = 50;           % A compléter
sigma_w    = v1 * 10^(-RSB_mesure/20); % A compléter
Rw         = sigma_w^2;                 % A compléter (scalaire car N=1)

[x_list,y_list] = creation_etat_obs(F, C, Ru, Rw, x1, T);

[G_list, x_post_list, P_post_list, x_prio_list, P_prio_list] = filtre_kalman(x_prio_1, P_prio_1, y_list, F, C, Ru, Rw);
x_prio_list = x_prio_list(:,1:T);
P_prio_list = P_prio_list(:,:,1:T);

n = 1:T;

figure;
subplot(211);
plot(n, x_list(1,:), 'k+', n, y_list, 'g*', n, x_prio_list(1,:), 'bo', n, x_post_list(1,:), 'rx');
legend('position vraie','position observée','estimée a priori','estimée a posteriori');
xlabel('temps en secondes'); ylabel('position en mètres');

subplot(212);
plot(n, x_list(2,:), 'k+', n, x_prio_list(2,:), 'bo', n, x_post_list(2,:), 'rx');
legend('vitesse vraie','estimée a priori','estimée a posteriori');
xlabel('temps en secondes'); ylabel('vitesse en m/s');

figure;
subplot(211);
plot(n, x_list(1,:)-y_list, 'g*', n, x_list(1,:)-x_prio_list(1,:), 'bo', n, x_list(1,:)-x_post_list(1,:), 'rx');
legend('bruit de mesure sur position','erreur de position a priori','erreur de position a posteriori');
xlabel('temps en secondes'); ylabel('distance en mètres');

subplot(212);
plot(n, x_list(2,:)-x_prio_list(2,:), 'bo', n, x_list(2,:)-x_post_list(2,:), 'rx');
legend('erreur de vitesse a priori','erreur de vitesse a posteriori');
xlabel('temps en secondes'); ylabel('vitesse en m/s');

P_prio_11 = P_prio_list(1,1,:);
P_prio_22 = P_prio_list(2,2,:);
P_post_11 = P_post_list(1,1,:);
P_post_22 = P_post_list(2,2,:);

figure;
subplot(211);
plot(n, P_prio_11(:), 'b', n, P_post_11(:), 'r');
legend('covariance a priori(1,1)','covariance a posteriori(1,1)');
xlabel('temps en secondes');

subplot(212);
plot(n, P_prio_22(:), 'b', n, P_post_22(:), 'r');
legend('covariance a priori(2,2)','covariance a posteriori(2,2)');
xlabel('temps en secondes');


figure; % Tracé des estimées et des ellipses de confiance associées
hold on; grid on; axis equal;
title('estimées a priori / a posteriori + ellipses à 0.9 de confiance');
xlabel('x_1'); ylabel('x_2');

% points estimés (choix : afficher toutes les estimations)
plot(x_prio_list(1,:), x_prio_list(2,:), 'bo');   % a priori
plot(x_post_list(1,:), x_post_list(2,:), 'rx');   % a posteriori

figure; % Tracé des estimées et des ellipses de confiance associées
hold on; grid on; axis equal;
title('Estimées + ellipses (eta = 0.9) à certains instants');
xlabel('x_1 (position)'); ylabel('x_2 (vitesse)');

eta = 0.9;

instants = [1 2 3 10 20 30 50 100];
colors   = {'r','g','b','c','m','y','k',[0.5 0.5 0.5]}; % 8 couleurs

for i = 1:length(instants)
    k = instants(i);

    col = colors{i};

    if ischar(col)
        plot(x_list(1,k), x_list(2,k), '+', 'Color', col, 'MarkerSize', 8, 'LineWidth', 1.5);
    else
        plot(x_list(1,k), x_list(2,k), '+', 'Color', col, 'MarkerSize', 8, 'LineWidth', 1.5);
    end

    plot(x_prio_list(1,k), x_prio_list(2,k), 'o', 'Color', col, 'MarkerSize', 6, 'LineWidth', 1.2);
    plot(x_post_list(1,k), x_post_list(2,k), 'x', 'Color', col, 'MarkerSize', 6, 'LineWidth', 1.2);

    if ischar(col)
        trace_ellipse(x_prio_list(:,k), P_prio_list(:,:,k), eta, [col '--']); % a priori : pointillé
        trace_ellipse(x_post_list(:,k), P_post_list(:,:,k), eta, [col '-']);  % a posteriori : plein
    else
    end
end

legend('vrai état (+)','a priori (o)','a posteriori (x)', 'Location','best');
hold off;






