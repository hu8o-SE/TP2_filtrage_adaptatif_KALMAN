
    x_post_list(:,n) = x_post;
    P_post_list(:,:,n) = P_post;

    plot(x_post(1), x_post(2), 'x', 'Color', couleurs(n,:));
    trace_ellipse(x_post, P_post, 0.9, '-');

    x_prio = x_prio_suiv;
    P_prio = P_prio_suiv;