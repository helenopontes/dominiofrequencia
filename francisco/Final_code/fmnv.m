function [w0,phi0,t,y,mg,kg,Deslocamentos]=fmnv(nos,elems,apoios,my,rho,ast,mi,flag_mass,F)
% -------------------------------------------------------------------------
% FMNV.M
% -------------------------------------------------------------------------
% Função de cálculo das frequências e dos modos naturais de vibração.
% -------------------------------------------------------------------------
% Parâmetros:
%   nos    (E) - Matriz das coordenadas XY dos nós organizadas por coluna.
%   elems  (E) - Matriz dos nós dos elementos organizados por coluna.
%   apoios (E) - Matriz das indicações de apoios organizadas por coluna.
%   my     (E) - Vetor dos módulos de Young das barras.
%   rho    (E) - Vetor das densidades das barras.
%   ast    (E) - Vetor das áreas das seções transversais das barras.
%   flag   (E) - Flag se massa é consistente (1) ou concentrada (0).
%   w0     (S) - Vetor das frequências naturais de vibração.
%   phi0   (S) - Matriz dos modos naturais de vibração organizados por
%                coluna.
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% -------------------------------------------------------------------------
% Por: Francisco de Assis Viana Binas Júnior
% -------------------------------------------------------------------------
% Versão:  19/02/2019
% -------------------------------------------------------------------------

% Monta a matriz dos graus de liberdade dos nós do modelo
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
    
    if flag_mass
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



% ============================ FUNÇÕES LOCAIS =============================

function ke=rigidez_viga(my,mi,noi,nof)
% -------------------------------------------------------------------------
% Função de cálculo da matriz de rigidez do elemento de viga 2d.
% -------------------------------------------------------------------------
% Parâmetros:
%   my  (E) - Módulo de Young ou de elasticidade longitudinal.
%   mi  (E) - Momento de inércia.
%   noi (E) - Vetor com as coordenadas XY do nó inicial.
%   nof (E) - Vetor com as coordenadas XY do nó final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projeção da barra em x
ya = nof(2) - noi(2);       %Projeção da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.

ke =[12*my*mi/(L^3) 6*my*mi/(L^2) -12*my*mi/(L^3) 6*my*mi/(L^2);
    6*my*mi/(L^2) 4*my*mi/L -6*my*mi/(L^2) 2*my*mi/L;
    -12*my*mi/(L^3) -6*my*mi/(L^2) 12*my*mi/(L^3) -6*my*mi/(L^2);
    6*my*mi/(L^2) 2*my*mi/L -6*my*mi/(L^2) 4*my*mi/L];


function ke=rigidez_trel(my,ast,noi,nof)
% -------------------------------------------------------------------------
% Função de cálculo da matriz de rigidez do elemento de treliça 2d.
% -------------------------------------------------------------------------
% Parâmetros:
%   my  (E) - Módulo de Young ou de elasticidade longitudinal.
%   ast (E) - Área da seção transversal.
%   noi (E) - Vetor com as coordenadas XY do nó inicial.
%   nof (E) - Vetor com as coordenadas XY do nó final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projeção da barra em x
ya = nof(2) - noi(2);       %Projeção da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
C = xa/L;                   %Cosseno do angulo de rotação da barra.
S = ya/L;                   %Seno do angulo de rotação da barra.
ke = (my*ast/L)*...
        [C*C C*S -C*C -C*S;
         C*S S*S -C*S -S*S;
         -C*C -C*S C*C C*S;
         -C*S -S*S C*S S*S];


function me=massa_consis_viga(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Função de cálculo da matriz de massa consistente do elemento de viga 2d.
% -------------------------------------------------------------------------
% Parâmetros:
%   rho (E) - Densidade.
%   ast (E) - Área da seção transversal.
%   noi (E) - Vetor com as coordenadas XY do nó inicial.
%   nof (E) - Vetor com as coordenadas XY do nó final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projeção da barra em x
ya = nof(2) - noi(2);       %Projeção da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/420)*...
        [156 22*L 54 -13*L;
         22*L 4*L*L 13*L -3*L*L;
         54 13*L 156 -22*L;
         -13*L -3*L*L -22*L 4*L*L];


function me=massa_concen_viga(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Função de cálculo da matriz de massa concentrada do elemento de viga 2d.
% -------------------------------------------------------------------------
% Parâmetros:
%   rho (E) - Densidade.
%   ast (E) - Área da seção transversal.
%   noi (E) - Vetor com as coordenadas XY do nó inicial.
%   nof (E) - Vetor com as coordenadas XY do nó final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projeção da barra em x
ya = nof(2) - noi(2);       %Projeção da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/78)*...
        [39 0 0 0;
         0 L*L 0 0;
         0 0 39 0;
         0 0 0 L*L];


function me=massa_consis_trel(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Função de cálculo da matriz de massa consistente do elemento de treliça
% 2d.
% -------------------------------------------------------------------------
% Parâmetros:
%   rho (E) - Densidade.
%   ast (E) - Área da seção transversal.
%   noi (E) - Vetor com as coordenadas XY do nó inicial.
%   nof (E) - Vetor com as coordenadas XY do nó final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projeção da barra em x
ya = nof(2) - noi(2);       %Projeção da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/6)*...
        [2 0 1 0;
         0 2 0 1;
         1 0 2 0;
         0 1 0 2];


function me=massa_concen_trel(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Função de cálculo da matriz de massa concentrada do elemento de treliça
% 2d.
% -------------------------------------------------------------------------
% Parâmetros:
%   rho (E) - Densidade.
%   ast (E) - Área da seção transversal.
%   noi (E) - Vetor com as coordenadas XY do nó inicial.
%   nof (E) - Vetor com as coordenadas XY do nó final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projeção da barra em x
ya = nof(2) - noi(2);       %Projeção da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/2)*...
        [1 0 0 0;
         0 1 0 0;
         0 0 1 0;
         0 0 0 1];
