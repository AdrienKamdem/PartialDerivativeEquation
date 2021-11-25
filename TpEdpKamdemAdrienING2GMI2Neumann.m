%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Condition de Neumann %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialisation des lignes du temps et de la fonction

L=1;
T=1;
M=4999;
N=19;
deltax = L/(N+1);
deltat = T/(M+1);

%% Découpage des abcsisses et des ordonnées

x=linspace(0,L,N+2);
t=linspace(0,T,M+2);

%% Initialisation des conditions initiales sur le maillage

for i=1:N+2
    u(1,i)=cond_init(x(i));
end

%% Conditions initiales affichage en t = 1 

figure;
plot(x,u(1,:));
title("Condition Initiales Neumann");

%% Programme principale calculant les conditions limites ainsi que la fonction

for n=1:M+1
    for i=2:N+1
        u(n+1,i)= u(n,i)+deltat*(((u(n,i+1)-2*u(n,i)+u(n,i-1))/(deltax^2))-5*u(n,i)) + deltat*(t(n)^2*cos(pi*x(i)));
    end
     u(n+1,1)=u(n+1,2)-deltax*cond_limit1(t(n+1));
     u(n+1,N+2)=u(n+1,N+1)+deltax*cond_limit2(t(n+1));
end

%% Affichage des conditions limites en x = 1 et x = N+2

figure;
plot(t,u(:,1),t,u(:,N+2));
title("Condition Limites");

%% Affichage de la fonction à t=T, t=T/2

figure;
plot(x,u(M+2,:));
plot(x,u(T/(2*deltat)+1,:));
title('solution t=T et T/2');

%% Affichage de la fonction 

figure;
mesh(x,t,u);
title("Resultat 3D Neumann"); 

%% Fontions utilisées pour les conditions initiales et limites 

function [f]=cond_init(x)
    f=(x-1)*(x-1);
end

function [f]=cond_limit1(t)
    f=-2+2*t;
end

function [f]=cond_limit2(t)
    f=20*sin(pi*t);
end
