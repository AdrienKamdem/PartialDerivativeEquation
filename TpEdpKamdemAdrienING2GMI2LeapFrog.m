%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Condition de Leap Frog %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Initialisation des lignes du temps et de la fonction

L=1;
T=0.1;
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
    u(2,i)= u(1,i); %conditions initiales de t=1 sont égales à celles de t=2 donc une seule courbe 
end

%% Conditions initiales affichage en t = 1 et t = 2

figure;
plot(x,u(1,:),x,u(2,:));
title("Condition Initiales Leap Frog");

%% Initialisation des conditions limites

for n=2:M+2
    u(n,1)= cond_limit1(t(n));
    u(n,N+2)= cond_limit2(t(n));
end

%% Conditions limites affichage

figure;
plot(t,u(:,1),t,u(:,N+2));
title("Condition Limites Leap Frog");

%% Programme principale calculant la fonction

for n=2:M+1
    u(n+1,1)= cond_limit1(n);
    for i=2:N+1
        u(n+1,i)=u(n-1,i)+(deltat/(deltax*deltax))*2*(u(n,i+1)-2*u(n,i)+u(n,i-1));
    end
    u(n+1,N+2)= cond_limit2(n);
end 

%% Affichage de la fonction à t=T, t=T/2

figure;
plot(x,u(M+2,:));
plot(x,u(T/(2*deltat)+1,:));
title('solution t=T et T/2');
%% Visualisation de la surface - solution

figure;
mesh(x,t,u);
title("Resultat 3D Leap Frog"); 

%% Fontions utilisées pour les conditions initiales et limites 

function [f] = cond_init(x)
    f=cos(3*pi*x);
end

function [f]=cond_limit1(t)
    f=1;
end

function [f]=cond_limit2(t)
    f=-1;
end