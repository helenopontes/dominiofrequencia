function [nosd, elemsd, apoiosd] = discret(nos, elems, apoios, dx)
%Função para a discretização da viga.
xmax = max(nos(1,:));
xmin = min(nos(1,:));
numelem = (xmax-xmin)/dx;
numnos = numelem + 1;

elemsd = zeros(2,numelem);
nosd = zeros(2,numnos);
apoiosd = zeros(2,numnos);

for i = 1:1:numnos
    nosd(1,i) = xmin + (i-1)*dx;
end

for i = 1:1:numelem
    elemsd(1,i) = i;
    elemsd(2,i) = i+1;
end

for i = 1:1:length(nos)
    aux = nos(1,i)*(1/dx) + 1;
    apoiosd(1,aux) = apoios(1,i);
    apoiosd(2,aux) = apoios(2,i);
end

end

