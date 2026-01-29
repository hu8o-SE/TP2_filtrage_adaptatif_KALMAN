clear; close all; clc;

alpha= [4 10 10 13 15];
beta= [0  1  5  5  3];
y_enon= [5 10 11 14 17];

T= length(y_enon);

F= eye(2);

Rw = 9;               
Ru= zeros(2);        

x_prio= [1; -1];      
P_prio= 4*eye(2);     

x_prio_list = zeros(2,T+1);
x_post_list = zeros(2,T);
P_prio_list = zeros(2,2,T+1);
P_post_list = zeros(2,2,T);

figure; 
hold on; 
grid on; 
axis equal;
xlabel('x_1'); ylabel('x_2');
title('estimées a priori / a posteriori + ellipses à 0.9 de confiance');

%couleurs = lines(T); 
couleurs = ['r','g','b','c','m','y','k'];

for n = 1:T
    C = [alpha(n) beta(n)];     
    y = y_enon(n);               

    x_prio_list(:,n) = x_prio;
    P_prio_list(:,:,n) = P_prio;

    plot(x_prio(1), x_prio(2), 'o', 'Color', couleurs(n));
    trace_ellipse(x_prio, P_prio, 0.9, [couleurs(n) '--']);

    [G, x_post, P_post, x_prio_suiv, P_prio_suiv] = iter_kalman(x_prio, P_prio, y, F, C, Ru, Rw);

    x_post_list(:,n)= x_post;
    P_post_list(:,:,n)= P_post;

    plot(x_post(1), x_post(2), 'x', 'Color', couleurs(n));
    trace_ellipse(x_post, P_post, 0.9, [couleurs(n) '-']);
    
    x_prio = x_prio_suiv;
    P_prio = P_prio_suiv;

    disp(x_post_list)

    pause;

end

legend('a priori','ellipse a priori 0.9','a posteriori','ellipse a posteriori 0.9');
