function fmnv_ex1
% -------------------------------------------------------------------------
% FMNV_EX1.M
% -------------------------------------------------------------------------
% Exemplo de cálculo das frequências e dos modos naturais de vibração de
% uma treliça 3d 
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

%H=1.5;
%V=1.5;

nos=[72 0 0 0; ...
     0 36 36 0;
     0 0 72 -48];

elems=[2 3 4; ...
       1 1 1];
   
apoios=[0 1 1 1; ...
        0 1 1 1;
        0 1 1 1];

my=6.894e10*ones(size(elems,2),1);

rho=2.714e3*ones(size(elems,2),1);

ast=4e-4*ones(size(elems,2),1);

% Solução com matriz de massa consistente
[w0_cons,phi0_cons]=fmnv(nos,elems,apoios,my,rho,ast,1);

w0_cons
T_cons=2*pi./w0_cons
f_cons=w0_cons/2/pi

for i=1:1
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

% set(gcf,'Name','Matriz de Massa Consistente');

% figure
% for i=1:2
%     for j=1:4
%         m=(i-1)*4+j;
%         subplot(2,4,m);
%         fmnv_plot(nos,elems,phi0_conc(:,m));
%         title([num2str(T_conc(m)) ' s / ' num2str(f_conc(m)/2/pi) ' Hz']);
%     end
% end

% set(gcf,'Name','Matriz de Massa Concentrada');