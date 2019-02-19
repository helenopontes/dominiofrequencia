function fmnv_plot(nos,elems,phi0)
% -------------------------------------------------------------------------
% FMNV_PLOT.M
% -------------------------------------------------------------------------
% Fun��o de plotagem da treli�a indeformada e do correspondente modo
% natural de vibra��o.
% -------------------------------------------------------------------------
% Par�metros:
%   nos    (E) - Matriz das coordenadas XY dos n�s organizadas por coluna.
%   elems  (E) - Matriz dos n�s dos elementos organizados por coluna.
%   phi0   (E) - Vetor do modo natural de vibra��o de interesse.
% -------------------------------------------------------------------------
% Universidade Federal de Alagoas - UFAL
% Centro de Tecnologia - CTEC
% Curso de Engenharia de Petr�leo - EPET
% An�lise Estrutural de Sistemas Mar�timos - EPET073
% -------------------------------------------------------------------------
% Por: Eduardo Nobre Lages (enl@lccv.ufal.br)
% -------------------------------------------------------------------------
% Vers�o: 08/08/2017
% -------------------------------------------------------------------------

% Desenha a treli�a indeformada
hold on
axis equal
grid on

for i=1:size(elems,2)
    Aux = nos(1,elems(:,i));
    Aux2 = nos(2,elems(:,i));
    Aux3 = nos(3,elems(:,i));
    surf(nos(1,elems(:,i)),nos(2,elems(:,i)),nos(3,elems(:,i)),'b','LineWidth',2);
end

for i=1:size(nos,2)
    surf(nos(1,i),nos(2,i),nos(3,i),'bo','LineWidth',2,'MarkerSize',6,'MarkerFaceColor',[1,1,1]);
end

% Calcula o fator de escala dos deslocamentos
dx=max(nos(1,:))-min(nos(1,:));
dy=max(nos(2,:))-min(nos(2,:));

umax=max(abs(phi0(1:2:end)));
vmax=max(abs(phi0(2:2:end)));

f=(dx/umax+dy/vmax)/50;

for i=1:size(elems,2)
    surf(nos(1,elems(:,i))+f*phi0(2*(elems(:,i)-1)+1)', ...
         nos(2,elems(:,i))+f*phi0(2*(elems(:,i)-1)+2)','r','LineWidth',2);
end

for i=1:size(nos,2)
    surf(nos(1,i)+f*phi0(2*(i-1)+1),nos(2,i)+f*phi0(2*(i-1)+2),'ro','LineWidth',2,'MarkerSize',6,'MarkerFaceColor',[1,1,1]);
end