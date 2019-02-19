%function fmnv_ex1
% -------------------------------------------------------------------------
% FMNV_EX1.M
% -------------------------------------------------------------------------
% Exemplo de c�lculo das frequ�ncias e dos modos naturais de vibra��o de
% uma treli�a 2d apresentada como exemplo 1 (grupo 1) na refer�ncia:
%   Gao, W. "Interval natural frequency and mode shape analysis for truss
%   structures with interval parameters", Finite Elements in Analysis and
%   Design, 42, 2006, pp. 471�477
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% Centro de Tecnologia - CTEC
% Curso de Engenharia de Petr�leo - EPET
% An�lise Estrutural de Sistemas Mar�timos - EPET073
% -------------------------------------------------------------------------
% Por: Eduardo Nobre Lages (enl@lccv.ufal.br)
% -------------------------------------------------------------------------
% Vers�o:  09/08/2017
% -------------------------------------------------------------------------

H=2;
V=1.5;

nos=[0 H H 2*H; ...
     0 0 V 0];

elems=[1 1 2 3 2; ...
       2 3 3 4 4];
   
apoios=[1 0 0 0; ...
        1 0 0 1];

my=1e8*ones(size(elems,2),1);

rho=2.714e3*ones(size(elems,2),1);

ast=4e-2*ones(size(elems,2),1);

% Solu��o com matriz de massa consistente
[w0_cons,phi0_cons,kg]=fmnv(nos,elems,apoios,my,rho,ast,1);

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

% Solu��o com matriz de massa concentrada
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