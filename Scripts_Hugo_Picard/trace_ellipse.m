function trace_ellipse(mx,Rx,eta,style)

% function trace_ellipse(mx,Rx,eta,style)
%
% Cette fonction trace l'ellipse de confiance de niveau eta associée à un vecteur aléatoire gaussien de moyenne mx et de matrice de covariance Rx.
% Le style de tracé est à préciser en 4ème entrée par une chaîne de caractères (cf. aide sur "plot"). 

if exist('style')==0,
    style='k';
end

s=[0:0.01:2*pi]; 

x=mx*ones(size(s))+sqrt(-2*log(1-eta))*chol(Rx,'lower')*[cos(s);sin(s)];

plot(x(1,:),x(2,:),style); 
