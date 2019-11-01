% EXEMPLO_RISER_VERTICAL.M
% -------------------------------------------------------------------------
% Exemplo de calculo das frequencias e dos modos naturais de vibracao de 
% um riser 2d.
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% -------------------------------------------------------------------------
clear;
clc;

% Coordenadas dos nos do elemento
nos=[0 0;...
     0 8];

% Conectividades
elems=[1;...
       2];

% Condicoes de apoios
apoios=[1 1;...
        1 0];

% Tamanho dos elementos para serem discretizados - metros.
dx = 2.0;

% Discretizacao
[nos, elems, apoios] = discret_riser(nos, elems, apoios, dx);

% Modulo de elasticidade em N/m2 ->para MPa divide por 10a6
my=4e10*ones(size(elems,2),1);

% Densidade
rho=200*ones(size(elems,2),1);

% area em m2
ast=ones(size(elems,2),1);

% Momento de inercia I em m2
mi=1e-3*ones(size(elems,2),1);

% Vetor de forcas
F = zeros(7,1);

%Consideração do peso próprio
W = zeros(7,1);
W(2) = 0.5*dx*(rho(1)*ast(1)*9.81 - 1025*ast(1)*9.81);
W(4) = 0.5*dx*(rho(1)*ast(1)*9.81 - 1025*ast(1)*9.81);
W(6) = 0.5*dx*(rho(1)*ast(1)*9.81 - 1025*ast(1)*9.81);
W(7) = 0.5*dx*(rho(1)*ast(1)*9.81 - 1025*ast(1)*9.81);
F = F - W;


% Solucao com matriz de massa consistente
flag_mass = 1;
flag_v_or_t = 1;
[w0_cons,phi0_cons,t1,y1,t2,y2,mg,kg, Deslocamentos]=fmnv_riser(nos,elems,apoios,my,rho,ast, mi,flag_mass,F,flag_v_or_t);

w0_cons;
T_cons=2*pi./w0_cons;
f_cons=w0_cons/2/pi;


plot(t1,y1(:,3),t2,y2(:,3));
xlabel('Tempo (s)');
ylabel('Deslocamento (m)');
legend('Linear','Não Linear')
