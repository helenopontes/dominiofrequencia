%Verificar se os vetores são vetores-linha
function [vx,vy,ux,uy] = VerificarVetor(vx,vy,ux,uy)

if (size(vx,2)==1)
    vx = vx';
end
if (size(vy,2)==1)
    vy = vy';
end
if (size(ux,2)==1)
    ux = ux';
end
if (size(uy,2)==1)
    uy = uy';
end