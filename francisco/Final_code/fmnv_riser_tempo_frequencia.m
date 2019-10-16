function [w0,phi0,t1,y1,t2,y2,tt,vt,mg,kg,Deslocamentos]=fmnv_riser_tempo_frequencia(nos,elems,apoios,my,rho,ast,mi,flag_mass,F,flag_v_or_t)
% -------------------------------------------------------------------------
% FMNV.M
% -------------------------------------------------------------------------
% Funcao de calculo das frequencias e dos modos naturais de vibracao.
% -------------------------------------------------------------------------
% Parametros:
%   nos         (E) - Matriz das coordenadas XY dos nos organizadas por coluna.
%   elems       (E) - Matriz dos nos dos elementos organizados por coluna.
%   apoios      (E) - Matriz das indicacoes de apoios organizadas por coluna.
%   my          (E) - Vetor dos modulos de Young das barras.
%   rho         (E) - Vetor das densidades das barras.
%   ast         (E) - Vetor das areas das secoes transversais das barras.
%   flag_mass   (E) - Flag se massa e consistente (1) ou concentrada (0).
%   flag_v_or_t (E) - Flag se viga (1), se trelica (0)
%   F           (E) - Vetor de forcas
%   w0          (S) - Vetor das frequencias naturais de vibracao.
%   phi0        (S) - Matriz dos modos naturais de vibracao organizados por
%                     coluna.
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% -------------------------------------------------------------------------
% Por: Francisco de Assis Viana Binas Junior
% -------------------------------------------------------------------------
% Versao:  19/02/2019
% -------------------------------------------------------------------------
% Atualização: Heleno Pontes Bezerra Neto
% -------------------------------------------------------------------------
% Versao:  26/08/2019
% -------------------------------------------------------------------------

% Monta a matriz dos graus de liberdade dos nos do modelo
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
    if flag_v_or_t
        ke=rigidez_viga(my(i),mi(i),nos(:,elems(1,i)),nos(:,elems(2,i)));
    else
        ke=rigidez_trel(my(i),ast(i),nos(:,elems(1,i)),nos(:,elems(2,i)));
    end
    
    if flag_mass
        if flag_v_or_t
            me=massa_consis_viga(rho(i),ast(i),nos(:,elems(1,i)),nos(:,elems(2,i)));
        else
            me=massa_consis_trel(rho(i),ast(i),nos(:,elems(1,i)),nos(:,elems(2,i)));
        end
    else
        if flag_v_or_t
            me=massa_concen_viga(rho(i),ast(i),nos(:,elems(1,i)),nos(:,elems(2,i)));
        else
            me=massa_concen_trel(rho(i),ast(i),nos(:,elems(1,i)),nos(:,elems(2,i)));
        end
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

%mg(4,4) = mg(4,4) + 100;

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
% deltat = 1; %Delta t em segundos

% Primeira e segunda Frequencia Natural:
w1 = w0(1);
w2 = w0(2);

ksi = 0.02;
vetorb = [ksi;ksi];
matrizA = [1/(2*w1),w1/2;1/(2*w2),w2/2];
xx = linsolve(matrizA,vetorb);

alpha = xx(1);
beta = xx(2);

% Amortecimento nulo por enquanto
%C = alpha.*mg + beta.*kg;
C = 0.*mg + 0.*kg;

NumForc = 2*length(F);
condIniciais = zeros(NumForc,1);

%tspan = linspace(0,4,1600);
tspan = linspace(0,4,512);

onda_riser;
Ft = zeros(7,512);
AuxFt = ones(1,512);
Ft(2,:) = F(2)*AuxFt;
Ft(4,:) = F(4)*AuxFt;
Ft(6,:) = F(6)*AuxFt;
Ft(7,:) = F(7)*AuxFt;

tt = zeros(1,512);
t = 0;
for i=1:1:512
    tt(i) = t;
    Ft(1,i) = onda_riser_FDL(t,[0,0,-6]);
    Ft(3,i) = onda_riser_FDL(t,[0,0,-4]);
    Ft(5,i) = onda_riser_FDL(t,[0,0,-2]); 
    t = t + 0.0025;
end

Ff = zeros(7,512);
Ff = [fft(Ft(1,:));fft(Ft(2,:));fft(Ft(3,:));fft(Ft(4,:));fft(Ft(5,:));fft(Ft(6,:));fft(Ft(7,:))];

MM = phi0aux'*mg*phi0aux;
KK = phi0aux'*kg*phi0aux;
CC = phi0aux'*C*phi0aux;

[vt] = dinamicaFreq_riser(MM,KK,CC,Ff);
%vt = phi0aux*Vt;
%vt=0;
t1=0;y1=0;t2=0;y2=0;
%[t1,y1] = ode45('func_ode_riser_FDL',tspan,condIniciais,[],mg,kg,C,F);
%[t2,y2] = ode45('func_ode_riser_FDNL',tspan,condIniciais,[],mg,kg,C,F);



% ============================ FUNï¿½ï¿½ES LOCAIS =============================

function ke=rigidez_viga(my,mi,noi,nof)
% -------------------------------------------------------------------------
% Funcao de calculo da matriz de rigidez do elemento de viga 2d.
% -------------------------------------------------------------------------
% Parametros:
%   my  (E) - Mï¿½dulo de Young ou de elasticidade longitudinal.
%   mi  (E) - Momento de inercia.
%   noi (E) - Vetor com as coordenadas XY do no inicial.
%   nof (E) - Vetor com as coordenadas XY do no final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projecao da barra em x
ya = nof(2) - noi(2);       %Projecao da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.

ke =[12*my*mi/(L^3) 6*my*mi/(L^2) -12*my*mi/(L^3) 6*my*mi/(L^2);
    6*my*mi/(L^2) 4*my*mi/L -6*my*mi/(L^2) 2*my*mi/L;
    -12*my*mi/(L^3) -6*my*mi/(L^2) 12*my*mi/(L^3) -6*my*mi/(L^2);
    6*my*mi/(L^2) 2*my*mi/L -6*my*mi/(L^2) 4*my*mi/L];


function ke=rigidez_trel(my,ast,noi,nof)
% -------------------------------------------------------------------------
% Funcao de calculo da matriz de rigidez do elemento de treliï¿½a 2d.
% -------------------------------------------------------------------------
% Parï¿½metros:
%   my  (E) - Modulo de Young ou de elasticidade longitudinal.
%   ast (E) - area da secao transversal.
%   noi (E) - Vetor com as coordenadas XY do no inicial.
%   nof (E) - Vetor com as coordenadas XY do no final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projecao da barra em x
ya = nof(2) - noi(2);       %Projecao da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
C = xa/L;                   %Cosseno do angulo de rotacao da barra.
S = ya/L;                   %Seno do angulo de rotacao da barra.
ke = (my*ast/L)*...
        [C*C C*S -C*C -C*S;
         C*S S*S -C*S -S*S;
         -C*C -C*S C*C C*S;
         -C*S -S*S C*S S*S];


function me=massa_consis_viga(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Funcao de calculo da matriz de massa consistente do elemento de viga 2d.
% -------------------------------------------------------------------------
% Parametros:
%   rho (E) - Densidade.
%   ast (E) - area da secao transversal.
%   noi (E) - Vetor com as coordenadas XY do no inicial.
%   nof (E) - Vetor com as coordenadas XY do no final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projecao da barra em x
ya = nof(2) - noi(2);       %Projecao da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/420)*...
        [156 22*L 54 -13*L;
         22*L 4*L*L 13*L -3*L*L;
         54 13*L 156 -22*L;
         -13*L -3*L*L -22*L 4*L*L];


function me=massa_concen_viga(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Funcao de calculo da matriz de massa concentrada do elemento de viga 2d.
% -------------------------------------------------------------------------
% Parametros:
%   rho (E) - Densidade.
%   ast (E) - area da secao transversal.
%   noi (E) - Vetor com as coordenadas XY do no inicial.
%   nof (E) - Vetor com as coordenadas XY do no final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projecao da barra em x
ya = nof(2) - noi(2);       %Projecao da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/78)*...
        [39 0 0 0;
         0 L*L 0 0;
         0 0 39 0;
         0 0 0 L*L];


function me=massa_consis_trel(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Funcao de calculo da matriz de massa consistente do elemento de trelica
% 2d.
% -------------------------------------------------------------------------
% Parï¿½metros:
%   rho (E) - Densidade.
%   ast (E) - area da secao transversal.
%   noi (E) - Vetor com as coordenadas XY do no inicial.
%   nof (E) - Vetor com as coordenadas XY do no final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projecao da barra em x
ya = nof(2) - noi(2);       %Projecao da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/6)*...
        [2 0 1 0;
         0 2 0 1;
         1 0 2 0;
         0 1 0 2];


function me=massa_concen_trel(rho,ast,noi,nof)
% -------------------------------------------------------------------------
% Funcao de calculo da matriz de massa concentrada do elemento de trelica
% 2d.
% -------------------------------------------------------------------------
% Parï¿½metros:
%   rho (E) - Densidade.
%   ast (E) - area da secao transversal.
%   noi (E) - Vetor com as coordenadas XY do no inicial.
%   nof (E) - Vetor com as coordenadas XY do no final.
%   ke  (S) - Matriz de rigidez do elemento.
% -------------------------------------------------------------------------

xa = nof(1) - noi(1);       %Projecao da barra em x
ya = nof(2) - noi(2);       %Projecao da barra em y.
L = sqrt(xa*xa + ya*ya);    %Comprimento da barra.
me = (rho*ast*L/2)*...
        [1 0 0 0;
         0 1 0 0;
         0 0 1 0;
         0 0 0 1];
