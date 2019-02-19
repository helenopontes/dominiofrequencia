function fmnv_ex2
% -------------------------------------------------------------------------
% FMNV_EX2.M
% -------------------------------------------------------------------------
% Exemplo de estrutura offshore fixa elaborado pelo aluno
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% Centro de Tecnologia - CTEC
% Curso de Engenharia de Petróleo - EPET
% Análise Estrutural de Sistemas Marítimos - EPET073
% -------------------------------------------------------------------------
% Por: Eduardo Nobre Lages (enl@lccv.ufal.br)
% -------------------------------------------------------------------------
% Versão:  08/08/2017
% -------------------------------------------------------------------------

nos=[0 25 3 22 6 19 9 16; ...
     0 0 15 15 30 30 45 45];

elems=[1 1 3 2 3 3 3 4 5 5 7 6 7; ...
       2 3 2 4 4 5 6 6 6 7 6 8 8];
   
apoios=[1 1 0 0 0 0 0 0; ...
        1 1 0 0 0 0 0 0];

my=2.0e11*ones(size(elems,2),1);

rho=2.714e3*ones(size(elems,2),1);

ast=3.74e-2*ones(size(elems,2),1);

% Solução com matriz de massa consistente
[w0_cons,phi0_cons]=fmnv(nos,elems,apoios,my,rho,ast,1);

w0_cons
T_cons=2*pi./w0_cons
f_cons=w0_cons/2/pi

for i=1:2
    for j=1:3
        m=(i-1)*3+j;
        subplot(2,3,m);
        fmnv_plot(nos,elems,phi0_cons(:,m));
        title([num2str(T_cons(m)) ' s / ' num2str(f_cons(m)) ' Hz']);
    end
end

% Solução com matriz de massa concentrada
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
    for j=1:3
        m=(i-1)*3+j;
        subplot(2,3,m);
        fmnv_plot(nos,elems,phi0_conc(:,m));
        title([num2str(T_conc(m)) ' s / ' num2str(f_conc(m)) ' Hz']);
    end
end

set(gcf,'Name','Matriz de Massa Concentrada');