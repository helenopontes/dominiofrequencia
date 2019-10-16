function [Vx,Vy] = ComputeVelocityAndAcelerations1(tx,ty)
%Função para ocálculo das velocidades e acelerações do fluido
n = 1;

[H, T, k, d, Zd, NumberOfWaves, Ampw, W, phase, pos]=GetGlobalWave();

while(n <= NumberOfWaves)
    Vxaux(n) = Ampw(n)*W(n)*exp(k(n)*Zd)*cos(k(n)*pos(1) - W(n)*tx + phase(n));
    Vyaux(n) = Ampw(n)*W(n)*exp(k(n)*Zd)*sin(k(n)*pos(1) - W(n)*ty + phase(n));
    
    %Vx2aux(n) = (H(n)/2)*W(n)*(cosh(k(n)*(Zd + d))/sinh(k(n)*d))*cos(k(n)*pos(1) - W(n)*t + phase(n));
    
    n = n + 1;
end

Vx = sum(Vxaux);
Vy = sum(Vyaux);
%Vx2 = nansum(Vx2aux);

end

