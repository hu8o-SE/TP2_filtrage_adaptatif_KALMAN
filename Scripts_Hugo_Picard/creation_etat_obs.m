function [x_list,y_list]=creation_etat_obs(F,C,Ru,Rw,x1,T)

% function [x_list,y_list]=creation_etat_obs(F,C,Ru,Rw,x1,T)
%
% Cette fonction génère des états (qui sont cachés) et des observations suivant le modèle d'état : 
%   x(n+1) = F x(n) + u(n), où u est un vecteur aléatoire gaussien centré de matrice de covariance Ru
%   y(n) = C x(n) + w(n), où w est un vecteur aléatoire gaussien centré de matrice de covariance Rw
% où on suppose que les matrices F, C, Ru et Rw ne varient pas au cours du temps.
%
% Variables d'entrée :
% -	les matrices F, C, Ru et Rw du modèle d'état, 
% - x1 le vecteur d'état initial (à l'instant n=1), 
% - T le nombre total d'instants souhaité (correspondant au nombre d'observations souhaité).
%
% Variables de sortie :
% -	x_list est la matrice contenant la suite des états (autrement dit, la nième colonne de cette matrice contiendra l'état à l'instant n),
% -	y_list est la matrice contenant la suite des observations (autrement dit, la nième colonne de cette matrice contiendra l'observation à l'instant n).

[N,M]=size(C);

if Ru==zeros(M,M),
    u_list=zeros(M,T);
else 
    [Lu,p]=chol(Ru,'lower');
    if p==0,
        u_list=Lu*randn(M,T);
    else
        error('La matrice Ru doit etre definie positive.')
    end
end

if Rw==zeros(N,N),
    w_list=zeros(N,T);
else 
    [Lw,p]=chol(Rw,'lower');
    if p==0,
        w_list=Lw*randn(N,T);
    else
        error('La matrice Rw doit etre definie positive.')
    end
end

x_list=zeros(M,T);
y_list=zeros(N,T);
x_list(:,1)=x1;
y_list(:,1)=C*x_list(:,1)+w_list(:,1);
for n=2:T,
    x_list(:,n)=F*x_list(:,n-1)+u_list(:,n-1);
    y_list(:,n)=C*x_list(:,n)+w_list(:,n);
end

