%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Condition de Neumann Dirichlet %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear variables
clc

%% Initialisation des lignes du temps et de la fonction
L=1;
T=1;
M=4999;
N=19;
x=linspace(0,L,N+2);
t=linspace(0,T,M+2); 
deltax=x(2); 
deltat=t(2); 


%%
Equation1_Euler(x,t,deltax,deltat,N,M);

%% Fontions utilisées pour les conditions initiales et limites 
function [f] = condition_initiale(x)
f = x*exp(x);
end

function [f] = condition1_limite(t)
f = sin(4*pi*t);
end
function [f] = condition2_limite(t)
f= 2*exp(1)*cos(2*pi*t);
end


function Equation1_Euler(x,t,deltax,deltat,N,M)

for i = 1:N+2
    u(1,i) = condition_initiale(x(i)); % Programmer la condition initiale
end

for n=1:M+1
    u(n+1,1) = condition1_limite(t(n+1)); % Programmation de la limite à gauche
    for i=2:N+1
        u(n+1,i) = u(n,i) + (deltat*((0.2*(u(n,i+1)+u(n,i-1)-2*u(n,i))/(deltax*deltax))-2*x(i)*x(i)*((u(n,i+1)-u(n,i))/deltax)+2*t(n)*u(n,i)+exp(x(i))*x(i)*t(n))); % Équation discrétisée
    end
    u(n+1,N+2) = u(n+1,N+1) + deltax*condition2_limite(t(n+1)); % Programmation de la limite à droite
end

figure;
plot(t,u(:,N+2),t,u(:,1)); % Tracer les conditions aux limites
title("Conditions aux limites")


figure;
mesh(x,t,u); % Visualiser la surface solution u(t(n),x(i))
xlabel("Coordonée x");
ylabel("Coordonée t");
zlabel("Fonction u");
title("Solution u(t)=u(xx)-2*x*x*u(x)+2*t*u+exp(x)*x*t")


end