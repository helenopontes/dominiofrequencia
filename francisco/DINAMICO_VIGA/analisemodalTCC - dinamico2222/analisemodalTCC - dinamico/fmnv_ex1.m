%function fmnv_ex1
% -------------------------------------------------------------------------
% FMNV_EX1.M
% -------------------------------------------------------------------------
% Exemplo de cálculo das frequências e dos modos naturais de vibração de
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% Centro de Tecnologia - CTEC
% Curso de Engenharia de Petróleo - EPET
% -------------------------------------------------------------------------
clear;
clc;
nos=[0 8;0 0];

elems=[1;2];
   
apoios=[1 1;0 0];

dx = 0.5; %tamanho dos elementos quando discretizados em metros.

[nos, elems, apoios] = discret(nos, elems, apoios, dx);

my=4e10*ones(size(elems,2),1); %Modulo de elasticidade em N/m2 ->para MPa divide por 10a6

rho=200*ones(size(elems,2),1);

ast=ones(size(elems,2),1); %Área em m2

mi=1e-3*ones(size(elems,2),1); %Momento de inérica I em m2

F = zeros(32,1);

F(4) = -700;
F(8) = -700;
F(12) = -700;
F(16) = -700;
F(20) = -700;
F(24) = -700;
F(28) = -700;

% Solução com matriz de massa consistente
[w0_cons,phi0_cons,t,y,mg,kg, Deslocamentos]=fmnv(nos,elems,apoios,my,rho,ast, mi,1,F);

w0_cons;
T_cons=2*pi./w0_cons;
f_cons=w0_cons/2/pi;


plot(t,y(:,16));
xlabel('Tempo (s)');
ylabel('Deslocamento (m)');