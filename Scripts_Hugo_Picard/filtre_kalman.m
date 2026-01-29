function [G_list, x_post_list, P_post_list, x_prio_list, P_prio_list] = filtre_kalman(x_prio_1, P_prio_1, y_list, F, C, Ru, Rw)

    [N, T] = size(y_list);
 
    M = length(x_prio_1);

    x_prio_list = zeros(M, T+1);
    P_prio_list= zeros(M, M, T+1);
    G_list= zeros(M, N, T);
    x_post_list= zeros(M, T);
    P_post_list= zeros(M, M, T);

    x_prio_list(:,1)= x_prio_1;
    P_prio_list(:,:,1) = P_prio_1;

    x_prio= x_prio_1;
    P_prio= P_prio_1;

    for n = 1:T
        y = y_list(:,n);

        [G, x_post, P_post, x_prio_suiv, P_prio_suiv] =iter_kalman(x_prio, P_prio, y, F, C, Ru, Rw);

        G_list(:,:,n) = G;
        x_post_list(:,n) = x_post;
        P_post_list(:,:,n)= P_post;

        x_prio_list(:,n+1)= x_prio_suiv;
        P_prio_list(:,:,n+1)= P_prio_suiv;

        x_prio = x_prio_suiv;
        P_prio = P_prio_suiv;

    end
end