% EXEMPLO_TREL.M
% -------------------------------------------------------------------------
% Exemplo de calculo das frequencias e dos modos naturais de vibraacao de
% uma trelica 2d.
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% -------------------------------------------------------------------------

clear;
clc;

% Coordenadas dos nos do elemento
H=2;
V=1.5;
nos=[0 H H 2*H; ...
     0 0 V 0];

% Conectividades
elems=[1 1 2 3 2; ...
       2 3 3 4 4];

% Condicoes de apoios
apoios=[1 0 0 0; ...
        1 0 0 1];

% Modulo de young E = modulo de elasticidade
my=1e8*ones(size(elems,2),1);

% Densidade
rho=2.714e3*ones(size(elems,2),1);

% Area
ast=4e-2*ones(size(elems,2),1);

% Momento de inercia I em m2
mi=1e-3*ones(size(elems,2),1);


% Vetor de forcas
F = zeros(5,1);
F(2) = -1000;

% Solucao com matriz de massa consistente
flag_mass = 1;
flag_v_or_t = 0;
[w0_cons,phi0_cons,t,y,mg,kg,Deslocamentos]=fmnv(nos,elems,apoios,my,rho,ast, mi,flag_mass,F,flag_v_or_t);

w0_cons
T_cons=2*pi./w0_cons
f_cons=w0_cons/2/pi

for i=1:2
    for j=1:2
        m=(i-1)*2+j;
        subplot(2,4,m);
        fmnv_plot(nos,elems,phi0_cons(:,m));
        title([num2str(T_cons(m)) ' s / ' num2str(f_cons(m)) ' Hz']);
    end
end

% Solucao com matriz de massa concentrada
[w0_conc,phi0_conc]=fmnv(nos,elems,apoios,my,rho,ast,0);

w0_conc
T_conc=2*pi./w0_conc
f_conc=w0_conc/2/pi

for i=1:size(phi0_conc,2)
    if dot(phi0_cons(:,i),phi0_conc(:,i))<0
        phi0_conc(:,i)=-phi0_conc(:,i);
    end
end

set(gcf,'Name','Matriz de Massa Consistente');

figure
for i=1:2
    for j=1:2
        m=(i-1)*2+j;
        subplot(2,4,m);
        fmnv_plot(nos,elems,phi0_conc(:,m));
        title([num2str(T_conc(m)) ' s / ' num2str(f_conc(m)) ' Hz']);
    end
end

set(gcf,'Name','Matriz de Massa Concentrada');