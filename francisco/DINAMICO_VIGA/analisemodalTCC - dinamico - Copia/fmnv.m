function [w0,phi0,t,y,mg,kg,Deslocamentos]=fmnv(nos,elems,apoios,my,rho,ast, mi,flag,F)
% -------------------------------------------------------------------------
% FMNV.M
% -------------------------------------------------------------------------
% Fun��o de c�lculo das frequ�ncias e dos modos naturais de vibra��o de
% uma treli�a 2d.
% -------------------------------------------------------------------------
% Par�metros:
%   nos    (E) - Matriz das coordenadas XY dos n�s organizadas por coluna.
%   elems  (E) - Matriz dos n�s dos elementos organizados por coluna.
%   apoios (E) - Matriz das indica��es de apoios organizadas por coluna.
%   my     (E) - Vetor dos m�dulos de Young das barras.
%   rho    (E) - Vetor das densidades das barras.
%   ast    (E) - Vetor das �reas das se��es transversais das barras.
%   flag   (E) - Flag se massa � consistente (1) ou concentrada (0).
%   w0     (S) - Vetor das frequ�ncias naturais de vibra��o.
%   phi0   (S) - Matriz dos modos naturais de vibra��o organizados por
%                coluna.
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% Centro de Tecnologia - CTEC
% Curso de Engenharia de Petr�leo - EPET
% An�lise Estrutural de Sistemas Mar�timos - EPET073
% -------------------------------------------------------------------------
% Por: Fulano dos Grudes (email)
% Professor: Eduardo Nobre Lages (enl@lccv.ufal.br)
% -------------------------------------------------------------------------
% Vers�o:  08/08/2017
% -------------------------------------------------------------------------

% Monta a matriz dos graus de liberdade dos n�s do modelo
glibn=zeros(size(apoios));

nglib=0;

for j=1:size(apoios,2)
    for i=1:size(apoios,1)
        if apoios(i,j)==0
            nglib=nglib+1;
            glibn(i,j)=nglib;
        end
    end
end

% Monta a matriz de rigidez e a matriz de massa do modelo
kg=zeros(nglib);
mg=zeros(nglib);

for i=1:size(elems,2)
    ke=rigidez(my(i),mi(i),nos(:,elems(1,i)),nos(:,elems(2,i)));
    
    if flag
        me=massa_cons(rho(i),ast(i),nos(:,elems(1,i)),nos(:,elems(2,i)));
    else
        me=massa_conc(rho(i),ast(i),nos(:,elems(1,i)),nos(:,elems(2,i)));        
    end
    
    glibe=[glibn(:,elems(1,i));glibn(:,elems(2,i))];
    
    for j=1:length(glibe)
        if glibe(j)~=0
            for k=1:length(glibe)
                if glibe(k)~=0
                    kg(glibe(j),glibe(k))=kg(glibe(j),glibe(k))+ke(j,k);
                    mg(glibe(j),glibe(k))=mg(glibe(j),glibe(k))+me(j,k);                    
                end
            end
        end
    end
end

mg(4,4) = mg(4,4) + 100;

% Resolve o problema de valor principal generalizado associado
[phi0aux,w02]=eig(kg,mg);

w0=sqrt(diag(w02));

phi0=zeros(2*size(nos,2),size(phi0aux,2));
for j=1:size(phi0aux,2)
    for i=1:size(nos,2)
        for k=1:size(glibn,1)
            if glibn(k,i)~=0
                phi0((i-1)*size(glibn,1)+k,j)=phi0aux(glibn(k,i),j);
            end
        end
    end
end

Deslocamentos = kg\F;
%---------------------Analise Dinamica-------------------------------------
%deltat = 1; %Delta t em segundos

%Primeira e segunda Frequencia Natural:
w1 = w0(1);
w2 = w0(2);

ksi = 0.02;
vetorb = [ksi;ksi];
matrizA = [1/(2*w1),w1/2;1/(2*w2),w2/2];
xx = linsolve(matrizA,vetorb);

alpha = xx(1);
beta = xx(2);

%Amortecimento nulo por enquanto
C = alpha.*mg + beta.*kg;
NumForc = 2*length(F);
condIniciais = zeros(NumForc,1);

tspan = linspace(0,4,1600);

[t,y] = ode45('func_ode',tspan,condIniciais,[],mg,kg,C,F);



% ============================ FUN��ES LOCAIS =============================

function ke=rigidez(my,mi,noi,nof)
% -------------------------------------------------------------------------
% Fun��o de c�lculo da matriz de rigidez do elemento de treli�a 2d.
% -------------------------------------------------------------------------
% Par�metros:
%   my  (E) - M�dulo de Young ou de elasticidade longitudinal.
%   ast (E) - �rea da se��o transversal.
%   noi (E) - Vetor com as coordenadas XY do n� inicial.
%   nof (E) - Vetor com as coordenadas XY do n� final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Proje��o da barra em x
ya = nof(2) - noi(2);       %Proje��o da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.


ke =[12*my*mi/(L^3) 6*my*mi/(L^2) -12*my*mi/(L^3) 6*my*mi/(L^2);
    6*my*mi/(L^2) 4*my*mi/L -6*my*mi/(L^2) 2*my*mi/L;
    -12*my*mi/(L^3) -6*my*mi/(L^2) 12*my*mi/(L^3) -6*my*mi/(L^2);
    6*my*mi/(L^2) 2*my*mi/L -6*my*mi/(L^2) 4*my*mi/L];





function me=massa_cons(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Fun��o de c�lculo da matriz de massa consistente do elemento de treli�a
% 2d.
% -------------------------------------------------------------------------
% Par�metros:
%   rho (E) - Densidade.
%   ast (E) - �rea da se��o transversal.
%   noi (E) - Vetor com as coordenadas XY do n� inicial.
%   nof (E) - Vetor com as coordenadas XY do n� final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Proje��o da barra em x
ya = nof(2) - noi(2);       %Proje��o da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/420)*...
        [156 22*L 54 -13*L;
         22*L 4*L*L 13*L -3*L*L;
         54 13*L 156 -22*L;
         -13*L -3*L*L -22*L 4*L*L];