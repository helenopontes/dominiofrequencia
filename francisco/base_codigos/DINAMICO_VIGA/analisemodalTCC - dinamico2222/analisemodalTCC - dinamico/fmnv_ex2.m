%function fmnv_ex1
% -------------------------------------------------------------------------
% FMNV_EX1.M
% -------------------------------------------------------------------------
% Exemplo de cálculo das frequências e dos modos naturais de vibração de
% uma treliça 2d apresentada como exemplo 1 (grupo 1) na referência:
%   Gao, W. "Interval natural frequency and mode shape analysis for truss
%   structures with interval parameters", Finite Elements in Analysis and
%   Design, 42, 2006, pp. 471–477
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% Centro de Tecnologia - CTEC
% Curso de Engenharia de Petróleo - EPET
% Análise Estrutural de Sistemas Marítimos - EPET073
% -------------------------------------------------------------------------
% Por: Eduardo Nobre Lages (enl@lccv.ufal.br)
% -------------------------------------------------------------------------
% Versão:  09/08/2017
% -------------------------------------------------------------------------
clear;
clc;
nos=[0 1.6 3.2 4.8 6.4 8;0 0 0 0 0 0];

elems=[1 2 3 4 5;2 3 4 5 6];
   
apoios=[1 1 1 1 1 1;0 0 0 0 0 0];

dx = 0.08; %tamanho dos elementos quando discretizados em metros.

[nos, elems, apoios] = discret(nos, elems, apoios, dx);

my=4e10*ones(size(elems,2),1);

rho=200*ones(size(elems,2),1);

ast=ones(size(elems,2),1);

mi=1e-3*ones(size(elems,2),1);

% Solução com matriz de massa consistente
[w0_cons,phi0_cons, kg]=fmnv(nos,elems,apoios,my,rho,ast, mi,1);

w0_cons
T_cons=2*pi./w0_cons;
f_cons=w0_cons/2/pi;

% 
% for i=1:2
%     for j=1:4
%         m=(i-1)*4+j;
%         subplot(2,4,m);
%         fmnv_plot(nos,elems,phi0_cons(:,m));
%         title([num2str(T_cons(m)) ' s / ' num2str(f_cons(m)) ' Hz']);
%     end
% end