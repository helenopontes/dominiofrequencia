function [Vx,Vy] = ComputeVelocityAndAcelerations(H, k, d, Zd, NumberOfWaves, Ampw, W, phase, t, pos)
%Função para ocálculo das velocidades e acelerações do fluido
n = 1;

while(n <= NumberOfWaves)
    Vxaux(n) = Ampw(n)*W(n)*exp(k(n)*Zd)*cos(k(n)*pos(1) - W(n)*t + phase(n));
    Vyaux(n) = Ampw(n)*W(n)*exp(k(n)*Zd)*sin(k(n)*pos(1) - W(n)*t + phase(n));
    
    %Vx2aux(n) = (H(n)/2)*W(n)*(cosh(k(n)*(Zd + d))/sinh(k(n)*d))*cos(k(n)*pos(1) - W(n)*t + phase(n));
    
    n = n + 1;
end

Vx = sum(Vxaux);
Vy = sum(Vyaux);
%Vx2 = nansum(Vx2aux);

end

