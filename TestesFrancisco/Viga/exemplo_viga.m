% EXEMPLO_VIGA.M
% -------------------------------------------------------------------------
% Exemplo de calculo das frequencias e dos modos naturais de vibracao de 
% uma viga 2d.
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% -------------------------------------------------------------------------
clear;
clc;

% Coordenadas dos nos do elemento
nos=[0 8;...
     0 0];

% Conectividades
elems=[1;...
       2];

% Condicoes de apoios
apoios=[1 1;...
        0 0];

% Tamanho dos elementos para serem discretizados - metros.
dx = 2.0;

% Discretizacao
[nos, elems, apoios] = discret(nos, elems, apoios, dx);

% Modulo de elasticidade em N/m2 ->para MPa divide por 10a6
my=4e10*ones(size(elems,2),1);

% Densidade
rho=200*ones(size(elems,2),1);

% area em m2
ast=ones(size(elems,2),1);

% Momento de inercia I em m2
mi=1e-3*ones(size(elems,2),1);

% Vetor de forcas
F = zeros(8,1);
F(4) = -1000;

% Solucao com matriz de massa consistente
flag_mass = 1;
flag_v_or_t = 1;
[w0_cons,phi0_cons,t,y,mg,kg, Deslocamentos]=fmnv(nos,elems,apoios,my,rho,ast, mi,flag_mass,F,flag_v_or_t);

w0_cons;
T_cons=2*pi./w0_cons;
f_cons=w0_cons/2/pi;

plot(t,y(:,4));
xlabel('Tempo (s)');
ylabel('Deslocamento (m)');
