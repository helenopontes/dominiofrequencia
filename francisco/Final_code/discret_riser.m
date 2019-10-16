function [nosd, elemsd, apoiosd] = discret_riser(nos, elems, apoios, dy)
%Função para a discretização da viga.
ymax = max(nos(2,:));
ymin = min(nos(2,:));
numelem = (ymax-ymin)/dy;
numnos = numelem + 1;

elemsd = zeros(2,numelem);
nosd = zeros(2,numnos);
apoiosd = zeros(2,numnos);

for i = 1:1:numnos
    nosd(2,i) = ymin + (i-1)*dy;
end

for i = 1:1:numelem
    elemsd(1,i) = i;
    elemsd(2,i) = i+1;
end

for i = 1:1:length(nos)
    aux = nos(2,i)*(1/dy) + 1;
    apoiosd(1,aux) = apoios(1,i);
    apoiosd(2,aux) = apoios(2,i);
end


