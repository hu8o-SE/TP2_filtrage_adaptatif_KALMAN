

function [G, x_post, P_post, x_prio_suiv, P_prio_suiv] = iter_kalman(x_prio, P_prio, y, F, C, Ru, Rw)


    G = (P_prio * C')/(C * P_prio * C' + Rw);

    innov = y - C * x_prio;

    x_post = x_prio + G * innov;

    M = size(x_prio,1);
    I = eye(M);

    P_post = (I - G * C) * P_prio;

    x_prio_suiv = F * x_post;

    P_prio_suiv = F * P_post * F'+ Ru;

end
