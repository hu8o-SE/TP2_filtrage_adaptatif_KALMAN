clear all; close all;

% Test de la fonction creation_etat_obs
%---------------------------------------
F = [1 1; 0 1]; 
C = [1 0];       

x1 = [0 ; 50];        % état initial : position = 0 m, vitesse = 50 m/s
v1 = x1(2);           % vitesse de référence pour le RSB
T = 100;              % nombre total d'instants

%% Cas n°1 : faible bruit système et faible bruit de mesure
RSB_etat = 50;        % en dB
sigma_u  = v1 * 10^(-RSB_etat/20);
sigma_u1 = sigma_u;
sigma_u2 = sigma_u;
Ru = diag([sigma_u1^2 sigma_u2^2]);

RSB_mesure = 50;      % en dB
sigma_w = v1 * 10^(-RSB_mesure/20);
Rw = sigma_w^2;

[x_list,y_list] = creation_etat_obs(F, C, Ru, Rw, x1, T);

n = 1:T;
figure;
subplot(211);
plot(n, x_list(1,:), 'k', n, y_list, 'g');
legend('position vraie','position observée');
xlabel('temps en secondes'); ylabel('position en mètres');
title('Faible bruit système et faible bruit de mesure');

subplot(212);
plot(n, x_list(2,:), 'k');
legend('vitesse vraie');
xlabel('temps en secondes'); ylabel('vitesse en m/s');


%% Cas n°2 : faible bruit système et fort bruit de mesure
RSB_etat = 50;        % en dB
sigma_u  = v1 * 10^(-RSB_etat/20);
sigma_u1 = sigma_u;
sigma_u2 = sigma_u;
Ru = diag([sigma_u1^2 sigma_u2^2]);

RSB_mesure = -5;      % en dB
sigma_w = v1 * 10^(-RSB_mesure/20);
Rw = sigma_w^2;

[x_list,y_list] = creation_etat_obs(F, C, Ru, Rw, x1, T);

n = 1:T;
figure;
subplot(211);
plot(n, x_list(1,:), 'k', n, y_list, 'g');
legend('position vraie','position observée');
xlabel('temps en secondes'); ylabel('position en mètres');
title('Faible bruit système et fort bruit de mesure');

subplot(212);
plot(n, x_list(2,:), 'k');
legend('vitesse vraie');
xlabel('temps en secondes'); ylabel('vitesse en m/s');


%% Cas n°3 : fort bruit système et faible bruit de mesure
RSB_etat = 25;        % en dB
sigma_u  = v1 * 10^(-RSB_etat/20);
sigma_u1 = sigma_u;
sigma_u2 = sigma_u;
Ru = diag([sigma_u1^2 sigma_u2^2]);

RSB_mesure = 40;      % en dB
sigma_w = v1 * 10^(-RSB_mesure/20);
Rw = sigma_w^2;

[x_list,y_list] = creation_etat_obs(F, C, Ru, Rw, x1, T);

n = 1:T;
figure;
subplot(211);
plot(n, x_list(1,:), 'k', n, y_list, 'g');
legend('position vraie','position observée');
xlabel('temps en secondes'); ylabel('position en mètres');
title('Fort bruit système et faible bruit de mesure');

subplot(212);
plot(n, x_list(2,:), 'k');
legend('vitesse vraie');
xlabel('temps en secondes'); ylabel('vitesse en m/s');
