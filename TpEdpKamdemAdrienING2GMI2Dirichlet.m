%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Condition de DIRICHLET %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Initialisation des lignes du temps et de la fonction

L=1;
T=1;
M=4999;
N=19;
delta_t = T / (M+1); 
delta_x = L /(N+1);

%% Découpage des abcsisses et des ordonnées

x = linspace(0,L,N+2);
t = linspace(0,T,M+2);

%% Initialisation des conditions initiales sur le maillage

for i=1:N+2
    u(1,i)=cond_init(x(i));
end

%% Conditions initiales affichage en t = 1 

figure;
plot(x, u(1,:));
title("Condition Initiales");

%% Initialisation de fonctions limites 

for n=2:M+2
    u(n,1)=cond_limit1(t(n));
    u(n,N+2)=cond_limit2(t(n));
end

%% Conditions limites affichage en x = 1 et x = N+2

figure;
plot(t,u(:,1),t,u(:,N+2));
title("Condition Limites");

%% Programme principale calculant la fonction

for n = 1:M+1
    for i = 2:N+1
        u(n+1,i) = u(n,i) + (delta_t)*( (u(n,i+1) + u(n,i-1) -2*u(n,i))/(delta_x)^2 + 8*((u(n,i+1)-u(n,i))/delta_x) ) + delta_t*((x(i)-1)*t(n)^2);
    end
end

%% Affichage de la fonction à t=T, t=T/2

figure;
plot(x,u(M+2,:));
plot(x,u(T/(2*deltat)+1,:));
title('solution t=T et T/2');

%% Affichage de la fonction en 3D

figure;
mesh(x,t,u);
title("Fonction 3D affichage");

%% Fontions utilisées pour les conditions limites et initiales

for n=2:M+2
    u(n,1)=cond_limit1(t(n));
    u(n,N+2)=cond_limit2(t(n));   
end

function [f] = cond_init(x)
    f = -5*sin(pi*x);
end

function [f] = cond_limit1(t)
    f = -t*exp(t)+sin(8*pi*t);
end

function [f] = cond_limit2(t)
    f = 10*t^2;
end