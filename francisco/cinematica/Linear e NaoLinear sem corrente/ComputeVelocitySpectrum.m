function [SVx] = ComputeVelocitySpectrum(W, k, d, Zd, NumberOfWaves, Hs, Tp, gama)
%Função para o cálculo dos espectros de velocidade
%W - rad/s
%k - rad/m
%d - metros
%Zd - metros

w = W./(2*pi);
n = 1;

while (n <= NumberOfWaves)
    
%     AuxSV = ComputeDensityEnergy(w(numWaves), Hs, Tp, gama);
%     
%     cosh1 = cosh(k(numWaves)*(Zd+d));
%     
%     sinh1 = sinh(k(numWaves)*(Zd+d));
%     
%     sinh2 = sinh(k(numWaves)*d);
%     
%     SVx(numWaves) = ((w(numWaves)*cosh1/sinh2)^2)*AuxSV;
    
    AuxSV = ComputeDensityEnergy(w(n), Hs, Tp, gama);
    
    SVx(n) = ((w(n)*2*pi*(exp(k(n)*Zd)))^2)*AuxSV;
     
    n = n + 1;
end

end

